Submonitor = {}

function Submonitor:split(monitor, split_x, split_y, x, y)
    sx, sy = monitor.getSize()
    ssx = math.floor(sx / split_x)
    ssy = math.floor(sy / split_y)
    
    return Submonitor:create(monitor, x * ssx, y * ssy, ssx, ssy)
end

function Submonitor:create(monitor, x, y, w, h)
    x = x or 0
    y = y or 0

    rx, ry = monitor.getSize()

    w = w or rx
    h = h or ry

    o = setmetatable({
        m = monitor,
        x = x,
        y = y,
        w = w,
        h = h,

        cx = 1,
        cy = 1,

        fg = colors.white,
        bg = colors.black,

        tfg = colors.white,
        tbg = colors.black,
    }, {__index=self})
        
    return o
end

function Submonitor:write(text)
    self.m.setCursorPos(self.cx + self.x, self.cy + self.y)
    self:startColors()
    
    for i=1,string.len(text) do
        self.m.write(string.sub(text, i, i))
        
        self.cx = self.cx + 1
        if self.cx > self.w then
            self.cx = 1
            self.cy = self.cy + 1
        end
        
        if self.cy > self.h then
            self.cy = 1
        end

        self.m.setCursorPos(self.cx + self.x, self.cy + self.y)
    end

    self:endColors()
end

function Submonitor:print(text)
    self:write(text)
    self.cy = math.min(self.cy + 1, self.h)
    self.cx = 0
end

function Submonitor:draw_rect(xa, ya, xb, yb, c)
    c = c or colors.red
    
    bg = self:getBackgroundColor()
    self:setBackgroundColor(c)
    
    xdir = ternary(xb > xa, 1, -1)
    ydir = ternary(yb > ya, 1, -1)
    
    for x=math.floor(xa),math.floor(xb),xdir do
        for y=math.floor(ya),math.floor(yb),ydir do
            self:setCursorPos(x, y)
            self:write(" ")
        end
    end
    
    self:setBackgroundColor(bg)
end

function Submonitor:clear()
    self:draw_rect(1, 1, self.w, self.h, self.bg)
end

function Submonitor:setCursorPos(x, y)
    self.cx = x
    self.cy = y
end

function Submonitor:getCursorPos()
    return self.cx, self.cy
end

function Submonitor:getSize()
    return self.w, self.h
end

function Submonitor:setBackgroundColor(color)
    self.bg = color
end

function Submonitor:getBackgroundColor(color)
    return self.bg
end

function Submonitor:setTextColor(color)
    self.fg = color
end

function Submonitor:getTextColor(color)
    return self.fg
end

function Submonitor:startColors()
    self.tbg = self.m.getBackgroundColor()
    self.tfg = self.m.getTextColor()

    self.m.setBackgroundColor(self.bg)
    self.m.setTextColor(self.fg)
end

function Submonitor:endColors()
    self.m.setBackgroundColor(self.tbg)
    self.m.setTextColor(self.tfg)
end