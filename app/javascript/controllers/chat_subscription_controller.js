import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="chat-subscription"
export default class extends Controller {
  static targets = ["messages"]
  static values = {
    chatroomId: Number,
    currentUserId: Number
  }
  connect() {
    console.log(this.chatroomIdValue)
    this.channel = createConsumer().subscriptions.create(
      { channel: "ChatChannel", id: this.chatroomIdValue },
      { received: data => { this.#insertMessageAndScrollDown(data) } }
    )
  }

  disconnect() {
    console.log("Disconnecting from the channel")
    this.channel.unsubscribe()
  }

  resetForm(event) {
    const form = event.target
    form.reset()
  }

  #insertMessageAndScrollDown(data) {
    const currentUserIsSender = this.currentUserIdValue === data.sender_id
    const messageElement = this.#buildMessageElement(currentUserIsSender, data.message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  #buildMessageElement(currentUserIsSender, message) {
    return `
    <div class="message-row d-flex ${this.#justifyClass(currentUserIsSender)}">
      <div class="${this.#userStyleClass(currentUserIsSender)}">
        ${message}
      </div>
    </div>
    `
  }

  #justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start"
  }

  #userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style"
  }
}
