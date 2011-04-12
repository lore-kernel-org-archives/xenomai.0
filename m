Message-ID: <4DA474C2.10203@domain.hid>
Date: Tue, 12 Apr 2011 17:50:26 +0200
From: Jesper Christensen <jbc@domain.hid>
MIME-Version: 1.0
References: <4D9F0679.7080109@domain.hid>	<1302268379.2101.35.camel@domain.hid>		<4DA30C80.3010107@domain.hid>	<1302531493.2054.355.camel@domain.hid>		<4DA30E14.6070401@domain.hid>	<1302532049.2054.357.camel@domain.hid>		<4DA31108.9080000@domain.hid>	<1302532753.2054	<4DA314F1.3070504@domain.hid>
	<4DA31EB6.4040909@domain.hid> <4DA4544F.7020300@domain.hid>
	<4DA45660.4000003@domain.hid> <4DA45D0F.4090501@domain.hid>
	<4DA45E42.5030500@domain.hid> <4DA45FD7.9000802@domain.hid>
	<4DA46EB8.3080008@domain.hid>
In-Reply-To: <4DA46EB8.3080008@domain.hid>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] kernel threads crash
List-Id: Xenomai life and development <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>


On 2011-04-12 17:24, Jan Kiszka wrote:
> On 2011-04-12 16:21, Jesper Christensen wrote:
>   
>> There you go:
>>
>>
>> -----------------------------------------------------------------------------------
>>
>> #include <linux/module.h>
>> #include <linux/kernel.h>
>> #include <linux/list.h>
>> #include <linux/workqueue.h>
>>
>> #include <rtnet_rtpc.h>
>> #include <up.h>
>>
>>
>>
>> static rtdm_lock_t      umsg_list_lock = RTDM_LOCK_UNLOCKED;
>> static rtdm_nrtsig_t    up_nrt_signal;
>> LIST_HEAD(umsg_list);
>>
>>
>> static void up_work_queue_handler(struct work_struct *work);
>> DECLARE_WORK(wq, up_work_queue_handler);
>>
>> u32 up_user_pid = 0;
>>
>> struct up_msg_buf *up_alloc_msg_buf(int cmd, size_t psize, struct
>> genl_info *info,
>>                                           up_msg_finalize fin)
>> {
>>    
>>     struct up_msg_buf *ret;
>>    
>>     ret = kmalloc(sizeof(struct up_msg_buf) + psize, GFP_KERNEL);
>>     if(!ret)
>>         return ret;
>>    
>>     memset(ret, 0, sizeof(struct up_msg_buf));
>>     
> [ kzalloc = kmalloc + memset ]
>
>   
Got it.
>>    
>>     /* Initialize some fields */
>>     if(info) {
>>         ret->pid = info->snd_pid;
>>         ret->seq = info->snd_seq;
>>     }
>>     ret->cmd = cmd;
>>     ret->finalize = fin;
>>    
>>    
>>     return ret;
>>    
>>    
>> }
>>
>> void up_queue_umsg(struct up_msg_buf *umsg, int op, int len, U8 upid)
>> {
>>    
>>     rtdm_lockctx_t context;
>>    
>>     umsg->hdr.opcode = op;
>>     umsg->hdr.plen = len;
>>     umsg->hdr.up_id = upid;
>>    
>>     rtdm_lock_get_irqsave(&umsg_list_lock, context);
>>     list_add_tail(&umsg->list_entry, &umsg_list);
>>     rtdm_lock_put_irqrestore(&umsg_list_lock, context);
>>    
>>     rtdm_nrtsig_pend(&up_nrt_signal);
>>    
>>     
> Why this signaling here? Either the message is processed synchronously
> (/wrt dispatch_call) so that you can release it after return from the
> dispatcher, or it's handled asynchronously, but then this signal comes
> too early as the RT work is potentially still ongoing.
>
>   
Well this is for dispatching messages the other way (via the
work_queue). The rt part will (by design) not modify the umsg buffer
after this call. This mechanism is also needed to pass unsolicited
messages from rt to userland.
>>    
>> }
>>
>>
>> static int up_handle_cmd_msg_rt(struct rt_proc_call *call)
>> {
>>    
>>     struct up_cmd_param *params;
>>     struct up_msg_buf *resp;
>>    
>>     params = rtpc_get_priv(call, struct up_cmd_param);
>>     resp = params->resp_buf;
>>    
>>     if(resp)
>>         resp->cmd = UP_NL_C_CMD;
>>    
>>     switch(params->hdr.opcode) {
>>        
>>         case UP_CMD_INIT:
>>             break;
>>
>>         case UP_CMD_CREATE_REQ:
>>         {
>>             struct up_config *c = (struct up_config *)&params->msg.config;
>>             int *res = (int *)resp->payload;
>>             *res = up_create(params->hdr.up_id, c);
>>     
> I can only assume this function doesn't do anything crazy.
>   
You are correct. It is only called once during startup.
>   
>>             if(*res < 0)
>>                 rtdm_printk("Error creating UP\n");
>>
>>             up_queue_umsg(resp, UP_CMD_CREATE_RES, sizeof(int), 0);
>>             break;
>>         }
>>
>>         default:
>>             rtdm_printk("Unknown cmd message: op=%d\n", params->hdr.opcode);
>>             return -ENOTSUPP;
>>        
>>     }
>>    
>>     return 0;
>> }
>>
>> static int up_handle_cmd_msg_nrt(struct sk_buff *skb, struct genl_info
>> *info)
>> {
>>    
>>     int ret;
>>     struct up_cmd_param params;
>>     struct up_user_hdr *uhdr = (struct up_user_hdr *)info->userhdr;
>>    
>>     //TODO: Allocate response buffer based on message type
>>     switch(uhdr->opcode) {
>>        
>>         case UP_CMD_INIT:
>>             up_user_pid = info->snd_pid;
>>             params.resp_buf = NULL;
>>             break;
>>            
>>         default:
>>             params.resp_buf = up_alloc_msg_buf(UP_NL_C_CMD,
>> sizeof(cmdMsg_t),
>>                                                     info, NULL);
>>             break;
>>     };
>>    
>>     memcpy(&params.hdr, info->userhdr, sizeof(struct up_user_hdr));
>>    
>>     if(params.hdr.plen > sizeof(cmdMsg_t))
>>         printk("up_handle_cmd_msg_nrt(): ERROR plen=%u >
>> sizeof(cmdMsg_t)=%u\n", params.hdr.plen, sizeof(cmdMsg_t));
>>    
>>     if(params.hdr.plen)
>>         nla_memcpy(&params.msg, info->attrs[UP_NL_A_MSG], params.hdr.plen);
>>    
>>     ret = rtpc_dispatch_call(up_handle_cmd_msg_rt, 0, &params,
>> sizeof(params),
>>                              NULL, NULL, NULL);
>>     
> That shouldn't build (too many arguments).
>   
That is actually a concurrency bug fix i made in rtnet (in the tar file
:) that prevented multiple userland threads from sending rt pings at the
same time.
>   
>>    
>>     if(ret < 0)
>>         kfree(params.resp_buf);
>>
>>     return ret;
>>
>> }
>>
>> /* netlink attribute policy */
>> static const struct nla_policy up_genl_policy[UP_NL_A_MAX + 1] = {
>>     [UP_NL_A_MSG] = { .type = NLA_BINARY }
>> };
>>
>> /* Generic netlink event operation definition */
>> static struct genl_ops up_genl_ops_cmd = {
>>     .cmd = UP_NL_C_CMD,
>>     .flags = 0,
>>     .policy = up_genl_policy,
>>     .doit = up_handle_cmd_msg_nrt,
>>     .dumpit = NULL
>> };
>>
>> /* Generic netlink family */
>> static struct genl_family up_genl_family = {
>>     .id = GENL_ID_GENERATE,
>>     .hdrsize = UP_GENL_HDRLEN,
>>     .name = "up",
>>     .version = UP_NL_VERSION,
>>     .maxattr = UP_NL_A_MAX
>> };
>>
>> static void up_work_queue_handler(struct work_struct *work)
>> {
>>    
>>     struct up_msg_buf *msg;
>>     struct sk_buff *skb;
>>     struct up_user_hdr *uhdr;
>>     rtdm_lockctx_t context;
>>     int rc;
>>    
>>     rtdm_lock_get_irqsave(&umsg_list_lock, context);
>>    
>>     while(!list_empty(&umsg_list)) {
>>         msg = (struct up_msg_buf *)umsg_list.next;
>>         list_del(&msg->list_entry);
>>         rtdm_lock_put_irqrestore(&umsg_list_lock, context);
>>        
>>         /* construct netlink message and send */
>>         skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
>>         if(!skb)
>>             goto failure;
>>        
>>         uhdr = genlmsg_put(skb, msg->pid, msg->seq, &up_genl_family,
>>                                0, msg->cmd);
>>         if(!uhdr)
>>             goto skb_failure;
>>        
>>         memcpy(uhdr, &msg->hdr, sizeof(struct up_user_hdr));
>>        
>>         rc = nla_put(skb, UP_NL_A_MSG, msg->hdr.plen, &msg->payload);
>>         if(rc != 0)
>>             goto skb_failure;
>>        
>>         genlmsg_end(skb, uhdr);
>>        
>>         rc = genlmsg_unicast(skb, msg->pid);
>>        
>>         if(msg->finalize)
>>             msg->finalize(msg);
>>         else
>>             kfree(msg);
>>        
>>         if(rc < 0)
>>             goto skb_failure;
>>        
>>         rtdm_lock_get_irqsave(&umsg_list_lock, context);
>>     }
>>    
>>     rtdm_lock_put_irqrestore(&umsg_list_lock, context);
>>    
>>     return;
>>
>> skb_failure:
>>     nlmsg_free(skb);
>> failure:
>>     printk("Response failure\n");
>>    
>> }
>>
>> static void up_signal_handler(rtdm_nrtsig_t nrt_sig, void *arg)
>> {
>>     /* Schedule work to be done in process context */
>>     schedule_work(&wq);
>> }
>>
>> static int __init up_init(void)
>> {
>>    
>>     int rc = 0;
>>     printk("UP module loading\n");
>>    
>>     rc = genl_register_family(&up_genl_family);
>>     if(rc != 0)
>>         return rc;
>>    
>>     rc = genl_register_ops(&up_genl_family, &up_genl_ops_cmd);
>>     if(rc != 0)
>>         goto failure;
>>    
>>     rc = rtdm_nrtsig_init(&up_nrt_signal, up_signal_handler, NULL);
>>     if(rc < 0)
>>         goto failure;
>>
>>     rc = up_init();
>>     
> Endless recursion???
>   
Woops, typo, sorry
>   
>>    
>>     if(rc < 0)
>>         goto failure;
>>
>>    
>>     return 0;
>>
>> failure:
>>     printk("UP module loading failed\n");
>>     genl_unregister_family(&up_genl_family);
>>     return rc;
>> }
>>
>>
>> static void __exit up_release(void)
>> {
>>    
>>     printk("UP module unloading\n");
>>     rtdm_nrtsig_destroy(&up_nrt_signal);
>>
>>     genl_unregister_family(&up_genl_family);
>>    
>>     up_release();
>>    
>> }
>>
>> module_init(up_init);
>> module_exit(up_release);
>>
>>     
> The way you use rtpc itself looks correct on first glance. But the two
> fishy spots and that signaling inconsistency I found make me wonder if
> this code corresponds to what crashes your box.
>
> Can you describe again what service rtpc needs to execute in the RT
> domain, and what data is exchanged between both worlds?
>
> Jan
>
>   

Thank you very much for your observations. To answer your question, the
data exchanged is basically session information which is used by two
threads on the rt side (session setup, release and modification). The
two threads receive udp packet from a ethernet interface, manipulates
some headers and forwards them on another interface (if the session
exists).
Now obviously i can not fully guarantee that there are no race
conditions there, but even then i cannot se how it should lead to a 
stack corruption.


/jesper


