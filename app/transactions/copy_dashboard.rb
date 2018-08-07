class CopyDashboard
  include Dry::Transaction

  step :duplicate

  private

  def duplicate(dashboard)
    dashboard = dashboard.deep_clone include: [
      lists: [
        cards: [
          comments: :attachment,
          attachments: nil
        ]
      ],
      labels: :cards
    ], use_dictionary: true
    dashboard.save
    Success(dashboard)
  end
end
