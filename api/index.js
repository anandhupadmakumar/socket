import http from "http";
import express from "express";
import { Server } from "socket.io";
import { Socket } from "dgram";


const app =express();
const server=http.createServer(app);
const io=new Server(server);



const userSockets=new Map();
io.on("connection",(socket)=>{
    console.log('Connected: ${socket.id}');
    socket.on("user-join",(data)=>{
        userSockets.set(data,socket.id);
        io.to(socket).emit("session-join","your session started");
    });

socket.on("disconnect",()=>{
    for (let [userId,socketId] of userSockets.entries()){
        if(socketId==socket.id){
            userSockets.delete(userId);
            break;
        }
    }
});

});



app.use(express.json());
app.get('/api/logout',(req,res)=>{
    const userId=req.query.userId;
    if(!userId){
        return res.status(400).json({success:false,message:"User ID is required"});
    }

    const socketId = userSockets.get(userId);
    if(socketId){
        io.to(socketId).emit("session-expired","your session has been terminated");
        return res.status(200).json({success:true,message:"logged out successfully"});
    }else{
        return res.status(400).json({success:false,message:"no active session found."})
    }
});


server.listen(3500,()=>{+
    +69
    console.log('server started');
});
