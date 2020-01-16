AddRemoteEvent("CUIAnimate", function(player, nearestNpc, animation)
    animation = animation or "WAVE2"
    SetNPCAnimation(nearestNpc, animation, false)
end)