class CommentsController < ApplicationController
    def create
        @article = Article.find(params[:article_id])

        @commnet = @article.comments.create(comments_params)
        redirect_to article_path(@article)
    end

    private
        def comments_params
            params.require(:comment).permit(:commenter, :body, :status)
        end

end
