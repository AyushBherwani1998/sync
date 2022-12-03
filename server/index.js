require('dotenv').config();
const express =require('express');
const cors =require('cors');
const bodyParser=require('body-parser');
const morgan = require('morgan');
const app =express();
const port = 8000;
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
app.use(morgan('dev'));
app.use(cors());

const { StaticJsonRpcProvider } =require('@ethersproject/providers');
const { AvatarResolver, utils: avtUtils }= require('@ensdomains/ens-avatar');
const { json } = require('body-parser');


app.get('/',(req,res)=>{
    return res.json("hello world")
})

app.get('/get_avatar/:ens',async (req,res)=>{
    let ens = req.params.ens
    if (ens==undefined || ens =="")
    return res.status(400).json({
        error:"no ens provided"
    });
    try {
        let uri = await get_avatar(ens)
        return res.status(200).json({
            data:{
                ens:ens,
                uri:uri
            }
        })
    }
    catch(err){
        return res.status(500).json({
            error:err
        })
    }
})


async function get_avatar(ens_address){
    let provider = new StaticJsonRpcProvider(
        "https://mainnet.infura.io/v3/36229aa90d54478bb93614edd05f06b0"
      );
    let avt = new AvatarResolver(provider);
    try {
        let avatarURI = await avt.getAvatar(ens_address)
        return avatarURI
    }
    catch(err){
        return err
    }
    
}

app.listen(port,()=>{
    console.log(`serving at  -- port : ${port}`)
});