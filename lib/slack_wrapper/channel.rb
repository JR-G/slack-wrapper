require 'slack-ruby-client'
require 'dotenv/load'

module SlackWrapper
  class Channel
    def initialize(token = nil, channel:)
      @channel = channel
      @token = token
    end

    def post_a_message!(text)
      slack_client.chat_postMessage(
        channel: @channel,
        text: text,
      )
    end

    def post_a_scheduled_message!(text, time)
      slack_client.chat_scheduleMessage(
        channel: @channel,
        text: text,
        post_at: time
      )
    end

    def pin_a_message!(message_timestamp)
      slack_client.pins_add(
        channel: @channel,
        timestamp: message_timestamp,
      )
    end

    def current_channel_topic
      slack_client.conversations_info(
        channel: @channel,
      ).dig(:channel, :topic, :value)
    end

    def current_members
      slack_client.conversations_members(
        channel: @channel,
      ).members
    end

    def create_public_channel!(channel_name)
      slack_client.conversations_create(
        name: channel_name,
        is_private: false,
      )
    end

    def create_private_channel!(channel_name)
      slack_client.conversations_create(
        name: channel_name,
        is_private: true,
      )
    end

    def invite_users!(users)
      slack_client.conversations_invite(
        channel: @channel,
        users: users.join(','),
      )
    end

    def invite_user!(user)
      slack_client.conversations_invite(
        channel: @channel,
        users: user,
      )
    end

    def create_channel_topic!(summary)
      slack_client.conversations_setTopic(
        channel: @channel,
        topic: summary,
      )
    end

    def slack_client
      @token || Slack::Web::Client.new(token: ENV['SLACK_TOKEN'])
    end
  end
end
