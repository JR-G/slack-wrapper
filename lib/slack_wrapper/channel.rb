require 'slack-ruby-client'
require 'dotenv/load'

module SlackWrapper
  class Channel
    attr_reader :identifier

    def initialize(identifier:, token: nil)
      @identifier = identifier
      @token = token
    end

    def post_a_message!(text:)
      slack_client.chat_postMessage(
        channel: identifier,
        text: text
      )
    end

    def post_a_scheduled_message!(text:, time:)
      slack_client.chat_scheduleMessage(
        channel: identifier,
        text: text,
        post_at: time
      )
    end

    def pin_a_message!(message_timestamp:)
      slack_client.pins_add(
        channel: identifier,
        timestamp: message_timestamp
      )
    end

    def current_topic
      slack_client.conversations_info(
        channel: identifier
      ).dig(:channel, :topic, :value)
    end

    def current_members
      slack_client.conversations_members(
        channel: identifier
      ).members
    end

    def self.create(is_private:, channel_name:)
      slack_client.conversations_create(
        name: channel_name,
        is_private: is_private
      )
    end

    def invite_users!(users:)
      slack_client.conversations_invite(
        channel: identifier,
        users: users.join(',')
      )
    end

    def invite_user!(user:)
      slack_client.conversations_invite(
        channel: identifier,
        users: user
      )
    end

    def create_topic!(summary:)
      slack_client.conversations_setTopic(
        channel: identifier,
        topic: summary
      )
    end

    def self.slack_client
      Slack::Web::Client.new(token: @token || ENV['SLACK_TOKEN'])
    end

    def slack_client
      @slack_client ||= self.class.slack_client
    end
  end
end
