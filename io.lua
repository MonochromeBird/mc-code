-- This script requires the Create: Tweaked Controller mod! --

function getAnalog(controller)
    return {
        left = {
            x = controller.getAxis(1),
            y = controller.getAxis(2),
            shoulder = controller.getButton(5),
            trigger = controller.getAxis(5),
            button = controller.getButton(10),
        },
        right = {
            x = controller.getAxis(3),
            y = controller.getAxis(4),
            shoulder = controller.getButton(6),
            trigger = controller.getAxis(6),
            button = controller.getButton(11),
        },
    }
end


function getButtons(controller)
    return {
        dpad = {
            up = controller.getButton(12),
            right = controller.getButton(13),
            down = controller.getButton(14),
            left = controller.getButton(15)
        },
        -- Buttons --
        cross = controller.getButton(1),
        circle = controller.getButton(2),
        square = controller.getButton(3),
        triangle = controller.getButton(4),
        -- Special --
        select = controller.getButton(7),
        start = controller.getButton(8),
        home = controller.getButton(9),
        -- Shoulders --
        left_shoulder = controller.getButton(5),
        right_shoulder = controller.getButton(6),
        -- Click --
        left_click = controller.getButton(10),
        right_click = controller.getButton(11),
    }
end