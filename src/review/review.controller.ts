import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  ParseIntPipe,
  Post,
  Put,
  UseGuards,
} from '@nestjs/common';
import { ReviewService } from './review.service';
import {
  ApiBearerAuth,
  ApiCreatedResponse,
  ApiNoContentResponse,
  ApiOkResponse,
  ApiOperation,
  ApiTags,
} from '@nestjs/swagger';
import { ReviewDto, ReviewListDto } from './dto/review.dto';
import { CreateReviewPayload } from './payload/create-review.payload';
import { JwtAuthGuard } from '../auth/guard/jwt-auth.guard';
import { CurrentUser } from '../auth/decorator/user.decorator';
import { UserBaseInfo } from '../auth/type/user-base-info.type';
import { UpdateReviewPayload } from './payload/update-review.paylaod';

@Controller('reviews')
@ApiTags('Review API')
export class ReviewController {
  constructor(private readonly reviewService: ReviewService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '리뷰 생성' })
  @ApiCreatedResponse({ type: ReviewDto })
  async createReview(
    @Body() payload: CreateReviewPayload,
    @CurrentUser() user: UserBaseInfo,
  ): Promise<ReviewDto> {
    return this.reviewService.createReview(payload, user);
  }

  @Get(':bookId')
  @ApiOperation({ summary: '책의 리뷰들 조회' })
  @ApiOkResponse({ type: ReviewListDto })
  async getReviewsByBookId(
    @Param('bookId', ParseIntPipe) bookId: number,
  ): Promise<ReviewListDto> {
    return this.reviewService.getReviewsByBookId(bookId);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '리뷰 수정' })
  async updateReview(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateReviewPayload,
    @CurrentUser() user: UserBaseInfo,
  ): Promise<ReviewDto> {
    return this.reviewService.updateReview(id, payload, user);
  }

  @Post(':reviewId/like')
  @HttpCode(204)
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '리뷰에 좋아요 누르기 (다시 누르면 취소)' })
  @ApiNoContentResponse()
  async toggleReviewLike(
    @Param('reviewId', ParseIntPipe) reviewId: number,
    @CurrentUser() user: UserBaseInfo,
  ): Promise<void> {
    return this.reviewService.toggleReviewLike(reviewId, user);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({ summary: '리뷰 삭제' })
  @HttpCode(204)
  async deleteReview(
    @Param('id', ParseIntPipe) id: number,
    @CurrentUser() user: UserBaseInfo,
  ): Promise<void> {
    return this.reviewService.deleteReview(id, user);
  }
}
