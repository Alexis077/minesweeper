class Cell < ApplicationRecord
    belongs_to :board
    enum state: {hidden: "hidden", flagged: "flagged", visible: "visible"}
end
