// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// コメント編集発火 //
/*global $ */$(document).on("turbolinks:load", () => {
  // 編集ボタンがクリックされた時の処理
  $("body").on("click", ".js-edit-comment-button",(e) => {
    // クリックされた編集ボタンの親要素からコメントIDを取得
    const commentId = $(e.target).parent().data('commentId');
    // 対応するコメントのラベル要素を取得
    const commentLabelArea = $('#js-comment-label-' + commentId);
    // 対応するコメントの編集用テキストエリアを取得
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    // 対応するコメントの更新ボタンを取得
    const commentButton = $('#js-comment-button-' + commentId);

    // コメントのラベルを非表示にする
    commentLabelArea.hide();
    // コメントの編集用テキストエリアを表示する
    commentTextArea.show();
    // コメントの更新ボタンを表示する
    commentButton.show();
  });

  // キャンセルボタンがクリックされた時の処理
  $("body").on("click", ".comment-cancel-button", (e) => {
    // クリックされたキャンセルボタンのデータ属性からコメントIDを取得
    const commentId = $(e.target).data('cancel-id');
    // 対応するコメントのラベル要素を取得
    const commentLabelArea = $('#js-comment-label-' + commentId);
    // 対応するコメントの編集用テキストエリアを取得
    const commentTextArea = $('#js-textarea-comment-' + commentId);
    // 対応するコメントの更新ボタンを取得
    const commentButton = $('#js-comment-button-' + commentId);
    // 対応するコメントのエラーメッセージ要素を取得
    const commentError = $('#js-comment-post-error-' + commentId);

    // コメントのラベルを再表示する
    commentLabelArea.show();
    // コメントの編集用テキストエリアを非表示にする
    commentTextArea.hide();
    // コメントの更新ボタンを非表示にする
    commentButton.hide();
    // コメントのエラーメッセージを非表示にする
    commentError.hide();
  });
})
