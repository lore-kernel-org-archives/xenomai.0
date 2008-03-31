Message-ID: <7289437c0803310940y6d2d4818m379c848bae9da001@domain.hid>
Date: Mon, 31 Mar 2008 18:40:12 +0200
From: "Perrine Martignoni" <perrmart@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_20927_15957656.1206981615131"
Subject: [Xenomai-help] Problem with rt_heap_create and rt_heap_alloc
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai-help <xenomai@xenomai.org>

------=_Part_20927_15957656.1206981615131
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I'm working on a MPC8347 with Linux-2.6.23 and xenomai-2.4.0.
And I have an issue with use of rt_heap_create and alloc.
When I create the memory heap, the result is that I lost the value of my
function parameters.
Here is my code :

*Driver code : *
static void *sp_kHeapMem = NULL;

typedef struct t_ArgumentTxCreateHeap t_ArgumentTxCreateHeap;
struct t_ArgumentTxCreateHeap
{
    RT_HEAP *p_Heap;
    void **p_HeapMem;
    char *name;
    int NbyteHeap;
};

/**************************************************************/
/*              dfpgatx_Ioctl=Fonction ioctl                  */
/**************************************************************/
static int dfpgatx_Ioctl(struct rtdm_dev_context   *p_Context,
                         rtdm_user_info_t          *p_UserInfo,
                         unsigned int               Cmd,
                         void                      *p_Argument)
{
    // p_Ctx : pointeur sur la structure t_FpgaTxContext
    t_FpgaTxContext *p_Ctx = (t_FpgaTxContext *)p_Context->dev_private;

    int ret = 0;

    switch (Cmd)
    {
   case TX_CREATE_HEAP : {
        // p_ArgUser : pointeur sur la structure t_ArgumentTxCreateHeap cote
utilisateur
        t_ArgumentTxCreateHeap *p_ArgUser = (t_ArgumentTxCreateHeap
*)p_Argument;

        // Arg : structure t_ArgumentTxCreateHeap cote noyau
        t_ArgumentTxCreateHeap Arg;

        RT_HEAP_INFO HeapInfo;
        char *name = NULL;

        // Copie de la structure t_ArgumentTxCreateHeap de l'espace
utilisateur vers l'espace noyau
        if (
rtdm_copy_from_user(p_UserInfo,&Arg,p_ArgUser,sizeof(t_ArgumentTxCreateHeap))
!= 0 )
        {
            rtdm_printk("Echec de la copie de la structure
t_ArgumentTxCreateHeap de l'espace utilisateur vers l'espace noyau\n");
            return -ECPYUSERKERN;
        }

        sp_kHeapMem = kmalloc(Arg.NbyteHeap, GFP_KERNEL);
        name = kmalloc((strlen(Arg.name)+1), GFP_KERNEL);

        // Copie du name de l'espace utilisateur vers l'espace noyau
        if ( (ret = rtdm_copy_from_user(p_UserInfo, name, Arg.name, (strlen(
Arg.name)+1))))
        {
           rtdm_printk("Echec de la copie de p_HeapMem de l'espace
utilisateur vers l'espace noyau\n");
           return -ECPYUSERKERN;
        }

       // Creation d'un espace memoire "memory heap" partage User/Kernel,
single Block et compatible DMA
        if((ret = rt_heap_create(Arg.p_Heap, name , Arg.NbyteHeap,
H_SHARED|H_DMA )))//H_SHARED|H_DMA
        {
           rtdm_printk("Impossible de creer l'espace memoire Heap : ret =
%d\n", ret);
        }

        rt_task_set_mode(0 ,T_PRIMARY, NULL);

        ret = rt_heap_alloc(Arg.p_Heap, Arg.NbyteHeap, TM_INFINITE,
&sp_kHeapMem);

        rt_heap_inquire(Arg.p_Heap, &HeapInfo);

        // Copie du p_HeapMem de l'espace noyau vers l'espace utilisateur
        if ( rtdm_copy_to_user(p_UserInfo,Arg.p_HeapMem,&sp_kHeapMem,
Arg.NbyteHeap) != 0 )
        {
            rtdm_printk("Echec de la copie de p_HeapMem de l'espace noyau
vers l'espace utilisateur\n");
            ret = -ECPYUSERKERN;
        }

        kfree(sp_kHeapMem);

        break;
    }

    default:
        rtdm_printk("Erreur : Commande non reconnue\n");
        ret = -EINVAL;
        break;
    }

    return ret;
}

/*******************************************************/
/*               Structures rtdm_device                */
/*******************************************************/
static struct rtdm_device t_FpgaTxDevice = {
    struct_version:     RTDM_DEVICE_STRUCT_VER,
    device_flags:       RTDM_NAMED_DEVICE,
    context_size:       sizeof(t_FpgaTxContext),
    device_name:        DEV_FILE_FPGATX,

    open_rt:        NULL,
    open_nrt:       dfpgatx_Open,

    ops:{
        close_rt:   NULL,
        close_nrt:  dfpgatx_Close,
        ioctl_rt:   dfpgatx_Ioctl,
        ioctl_nrt:  dfpgatx_Ioctl,
        read_rt:    NULL,
        read_nrt:   NULL,
        write_rt:   NULL,
        write_rt:   NULL,
        recvmsg_rt: NULL,
        recvmsg_nrt:NULL,
        sendmsg_rt: NULL,
        sendmsg_nrt:NULL,
    },
    device_class:       RTDM_CLASS_EXPERIMENTAL,
    device_sub_class:   222,
    driver_name:        DRV_NAME,
    peripheral_name:    DEV_FILE_NAME,
    provider_name:      "-",
    proc_name:          t_FpgaTxDevice.device_name,
};

/****************************************/
/*            Init Driver               */
/****************************************/
static int dfpgatx_Init(void)
{
    if(rtdm_dev_register(&t_FpgaTxDevice)!=0)
        rtdm_printk("Enregistrement impossible du device FPGA TX \n");
    else
        rtdm_printk("Initialisation OK\n");

    return 0;
}

/***************************************/
/*             Exit Driver             */
/***************************************/
static void dfpgatx_Exit(void)
{
    if(rtdm_dev_unregister(&t_FpgaTxDevice,0))
        rtdm_printk("Desabonnement KO\n");
    else
        rtdm_printk("Desabonnement OK\n");
}


module_init(dfpgatx_Init);
module_exit(dfpgatx_Exit);

*User code : (I launch WFPGATX_TestDMA() in a real-time task)*
typedef struct t_ArgumentTxCreateHeap t_ArgumentTxCreateHeap;
struct t_ArgumentTxCreateHeap
{
    RT_HEAP *p_Heap;
    void **p_HeapMem;
    char *name;
    int NbyteHeap;
};
static int s_DevFpgaTx = 0;

int WFPGATX_CreateHeap(RT_HEAP *p_Heap, char* name, void **const p_HeapMem,
const int NbyteHeap)
{
    int ret = ETX_NOERROR;
    t_ArgumentTxCreateHeap ArgCreateHeap;
    RT_HEAP_INFO HeapInfo;


    rt_task_set_mode(T_PRIMARY ,0, NULL);

    ArgCreateHeap.p_HeapMem = p_HeapMem;
    ArgCreateHeap.NbyteHeap = NbyteHeap;
    ArgCreateHeap.p_Heap = p_Heap;
    ArgCreateHeap.name = name;

    if(rt_dev_ioctl(s_DevFpgaTx, TX_CREATE_HEAP, &ArgCreateHeap))
        return -ETX_EXEC;

    return ret;
}

int WFPGATX_TestDMA(void *const p_Buffer, char *p_BufferRec, const int
Nbyte)
{
    int ret = ETX_NOERROR;
    void *p_HeapMem = NULL;
    RT_HEAP Heap;
    int i = 0;

printf("Nbyte %d\n",Nbyte );
printf("BufferRec %p\n",p_BufferRec );


    WFPGATX_CreateHeap(&Heap, "HeapTxTestDMA", &p_HeapMem, Nbyte);

printf("Nbyte %d\n",Nbyte );
printf("BufferRec %p\n",p_BufferRec );
printf("p_HeapMem %p\n",p_HeapMem );


    return ret;
}

int WFPGATX_End()
{
    int ret = ETX_NOERROR;
    // On effectue la fermeture du device
    rt_dev_close(s_DevFpgaTx);
    return ret;
}

int WFPGATX_Init(const int TaskPrio)
{
    int ret = ETX_NOERROR;

    // On effectue l'ouverture du device
    s_DevFpgaTx = rt_dev_open(DEV_FILE_FPGATX, 0);
    if(s_DevFpgaTx < 0)
    {
        printf("Impossible d'ouvrir le device\n");
        return -ETX_EXEC;
    }

    return ret;
}
*
And here is my trace : *
[   35.061131] Unable to handle kernel paging request for data at address
0x30036f24
[   35.068793] Faulting instruction address: 0xc0065480
[   35.073783] Oops: Kernel access of bad area, sig: 11 [#1]
[   35.080561] PREEMPT TH IPBB
[   35.083365] Modules linked in: DFPGATX_Main DGPIO_PCA9698
[   35.088797] NIP: c0065480 LR: c0065d08 CTR: c0064ebc
[   35.093776] REGS: c06b3c30 TRAP: 0300   Not tainted  (2.6.23)
[   35.099535] MSR: 00001032 <ME,IR,DR>  CR: 42004424  XER: 20000000
[   35.105684] DAR: 30036f24, DSISR: 20000000
[   35.109791] TASK = cfe23410[745] 'Main_TestDMA' THREAD: c06b2000
[   35.115638] GPR00: 00000001 c06b3ce0 cfe23410 c03ce0a4 00000000 00000000
c03c0000 c0398980
[   35.124068] GPR08: c0398980 c03e0000 c0398980 00000000 22002422 1001c37c
0fffa000 00000001
[   35.132498] GPR16: c03d0000 c0384380 c03c9bc0 00000058 c03b0000 c03dc7d0
c03dc804 c03a0000
[   35.140928] GPR24: cfc3d0a0 c0398980 cfc3d0d4 c03b0000 00000000 30036f24
30036de0 00000001
[   35.149538] NIP [c0065480] __shadow_eventcb+0x5c4/0x1424
[   35.154894] LR [c0065d08] __shadow_eventcb+0xe4c/0x1424
[   35.160144] Call Trace:
[   35.162595] [c06b3ce0] [c0065d08] __shadow_eventcb+0xe4c/0x1424
(unreliable)
[   35.169688] [c06b3d20] [c0056db8] detach_ppd+0x38/0x60
[   35.174855] [c06b3d40] [c0058ad0] cleanup_event+0xd4/0x19c
[   35.180370] [c06b3d70] [c0049d0c] __ipipe_dispatch_event+0x9c/0x1cc
[   35.186678] [c06b3dc0] [c001a9b8] mmput+0x6c/0x144
[   35.191508] [c06b3dd0] [c001ed6c] exit_mm+0xac/0x110
[   35.196505] [c06b3df0] [c0020194] do_exit+0x164/0x96c
[   35.201584] [c06b3e30] [c00209d4] do_group_exit+0x38/0xbc
[   35.207013] [c06b3e40] [c002cafc] get_signal_to_deliver+0x29c/0x4a0
[   35.213327] [c06b3e80] [c0009150] do_signal+0x44/0x294
[   35.218502] [c06b3f40] [c0010a84] do_user_signal+0x74/0xc4
[   35.224027] --- Exception: c00 at 0xffaa228
[   35.228228]     LR = 0xffaa200
[   35.231286] Instruction dump:
[   35.234265] 5400103a 7d39002e 81690000 61600001 557c07fe 90090000
2f9f0000 7ffdfb78
[   35.242082] 419e005c 807be514 3bddfebc 7f84e378 <83fd0000> 8003fffc
3863fffc 7fead278
[   35.250083] Fixing recursive fault but reboot is needed!
Nbyte 16
BufferRec 0x100150b0
Nbyte 0
BufferRec (nil)
p_HeapMem 0xcf164030


We see that Nbyte and BufferRec are reseted. I don't see why .
Any idea ?

Thanks in advance,

Perrine Martignoni

------=_Part_20927_15957656.1206981615131
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello, <br><br>I&#39;m working on a MPC8347 with Linux-2.6.23 and xenomai-2.4.0.<br>And I have an issue with use of rt_heap_create and alloc.<br>When I create the memory heap, the result is that I lost the value of my function parameters.<br>
Here is my code : <br><br><b>Driver code : </b><br><span style="font-family: courier new,monospace;">static void *sp_kHeapMem = NULL;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">typedef struct t_ArgumentTxCreateHeap t_ArgumentTxCreateHeap;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">struct t_ArgumentTxCreateHeap</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; RT_HEAP *p_Heap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; void **p_HeapMem;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; char *name;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int NbyteHeap;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">};</span><br><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">/**************************************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dfpgatx_Ioctl=Fonction ioctl&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">/**************************************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static int dfpgatx_Ioctl(struct rtdm_dev_context&nbsp;&nbsp; *p_Context,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_user_info_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_UserInfo,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cmd,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *p_Argument)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; // p_Ctx : pointeur sur la structure t_FpgaTxContext</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; t_FpgaTxContext *p_Ctx = (t_FpgaTxContext *)p_Context-&gt;dev_private;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = 0;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; switch (Cmd)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; case TX_CREATE_HEAP : {</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // p_ArgUser : pointeur sur la structure t_ArgumentTxCreateHeap cote utilisateur </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t_ArgumentTxCreateHeap *p_ArgUser = (t_ArgumentTxCreateHeap *)p_Argument;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Arg : structure t_ArgumentTxCreateHeap cote noyau </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t_ArgumentTxCreateHeap Arg;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RT_HEAP_INFO HeapInfo;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; char *name = NULL;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Copie de la structure t_ArgumentTxCreateHeap de l&#39;espace utilisateur vers l&#39;espace noyau </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ( rtdm_copy_from_user(p_UserInfo,&amp;Arg,p_ArgUser,sizeof(t_ArgumentTxCreateHeap)) != 0 )</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Echec de la copie de la structure t_ArgumentTxCreateHeap de l&#39;espace utilisateur vers l&#39;espace noyau\n&quot;);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ECPYUSERKERN;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } </span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sp_kHeapMem = kmalloc(Arg.NbyteHeap, GFP_KERNEL);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; name = kmalloc((strlen(<a href="http://Arg.name">Arg.name</a>)+1), GFP_KERNEL);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Copie du name de l&#39;espace utilisateur vers l&#39;espace noyau </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ( (ret = rtdm_copy_from_user(p_UserInfo, name, <a href="http://Arg.name">Arg.name</a>, (strlen(<a href="http://Arg.name">Arg.name</a>)+1))))</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; rtdm_printk(&quot;Echec de la copie de p_HeapMem de l&#39;espace utilisateur vers l&#39;espace noyau\n&quot;);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp; return -ECPYUSERKERN;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }&nbsp; </span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Creation d&#39;un espace memoire &quot;memory heap&quot; partage User/Kernel, single Block et compatible DMA</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if((ret = rt_heap_create(Arg.p_Heap, name , Arg.NbyteHeap, H_SHARED|H_DMA )))//H_SHARED|H_DMA</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Impossible de creer l&#39;espace memoire Heap : ret = %d\n&quot;, ret);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } </span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; rt_task_set_mode(0 ,T_PRIMARY, NULL);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = rt_heap_alloc(Arg.p_Heap, Arg.NbyteHeap, TM_INFINITE, &amp;sp_kHeapMem);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rt_heap_inquire(Arg.p_Heap, &amp;HeapInfo);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; // Copie du p_HeapMem de l&#39;espace noyau vers l&#39;espace utilisateur</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; if ( rtdm_copy_to_user(p_UserInfo,Arg.p_HeapMem,&amp;sp_kHeapMem,Arg.NbyteHeap) != 0 )</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; {</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Echec de la copie de p_HeapMem de l&#39;espace noyau vers l&#39;espace utilisateur\n&quot;);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -ECPYUSERKERN;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(sp_kHeapMem);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; }</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; default: </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Erreur : Commande non reconnue\n&quot;);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret = -EINVAL; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; }</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/*******************************************************/</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Structures rtdm_device&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/*******************************************************/</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">static struct rtdm_device t_FpgaTxDevice = {</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; struct_version:&nbsp;&nbsp;&nbsp;&nbsp; RTDM_DEVICE_STRUCT_VER,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_flags:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_NAMED_DEVICE,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; context_size:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sizeof(t_FpgaTxContext),</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DEV_FILE_FPGATX, </span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; open_rt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; open_nrt:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dfpgatx_Open,</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ops:{</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; close_nrt:&nbsp; dfpgatx_Close,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_rt:&nbsp;&nbsp; dfpgatx_Ioctl,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ioctl_nrt:&nbsp; dfpgatx_Ioctl,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_rt:&nbsp;&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_nrt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; write_rt:&nbsp;&nbsp; NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_rt: NULL, </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recvmsg_nrt:NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_rt: NULL,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sendmsg_nrt:NULL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; },</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_class:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RTDM_CLASS_EXPERIMENTAL,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; device_sub_class:&nbsp;&nbsp; 222,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; driver_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRV_NAME,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; peripheral_name:&nbsp;&nbsp;&nbsp; DEV_FILE_NAME,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; provider_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;-&quot;,</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; proc_name:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; t_FpgaTxDevice.device_name,</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">};</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/****************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Init Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">/****************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static int dfpgatx_Init(void) </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{&nbsp;&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(rtdm_dev_register(&amp;t_FpgaTxDevice)!=0) </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Enregistrement impossible du device FPGA TX \n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; else</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Initialisation OK\n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return 0;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/***************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">/*&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Exit Driver&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">/***************************************/</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static void dfpgatx_Exit(void) </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(rtdm_dev_unregister(&amp;t_FpgaTxDevice,0))</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement KO\n&quot;);&nbsp;&nbsp; </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; else</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; rtdm_printk(&quot;Desabonnement OK\n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">module_init(dfpgatx_Init);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">module_exit(dfpgatx_Exit);</span><br><br><b>User code : (I launch <span style="font-family: courier new,monospace;">WFPGATX_TestDMA() in a real-time task)</span></b><br><span style="font-family: courier new,monospace;">typedef struct t_ArgumentTxCreateHeap t_ArgumentTxCreateHeap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">struct t_ArgumentTxCreateHeap</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; RT_HEAP *p_Heap;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; void **p_HeapMem;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; char *name;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int NbyteHeap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">};</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">static int s_DevFpgaTx = 0;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">int WFPGATX_CreateHeap(RT_HEAP *p_Heap, char* name, void **const p_HeapMem, const int NbyteHeap)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = ETX_NOERROR;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; t_ArgumentTxCreateHeap ArgCreateHeap;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; RT_HEAP_INFO HeapInfo;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; rt_task_set_mode(T_PRIMARY ,0, NULL);</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ArgCreateHeap.p_HeapMem = p_HeapMem;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ArgCreateHeap.NbyteHeap = NbyteHeap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ArgCreateHeap.p_Heap = p_Heap;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; ArgCreateHeap.name = name;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(rt_dev_ioctl(s_DevFpgaTx, TX_CREATE_HEAP, &amp;ArgCreateHeap))</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; return -ETX_EXEC;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">int WFPGATX_TestDMA(void *const p_Buffer, char *p_BufferRec, const int Nbyte)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = ETX_NOERROR;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; void *p_HeapMem = NULL;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; RT_HEAP Heap;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int i = 0;</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">printf(&quot;Nbyte %d\n&quot;,Nbyte );</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">printf(&quot;BufferRec %p\n&quot;,p_BufferRec );</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; WFPGATX_CreateHeap(&amp;Heap, &quot;HeapTxTestDMA&quot;, &amp;p_HeapMem, Nbyte);</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">printf(&quot;Nbyte %d\n&quot;,Nbyte );</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">printf(&quot;BufferRec %p\n&quot;,p_BufferRec );</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">printf(&quot;p_HeapMem %p\n&quot;,p_HeapMem );</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">int WFPGATX_End()</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = ETX_NOERROR;</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; // On effectue la fermeture du device </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; rt_dev_close(s_DevFpgaTx);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">int WFPGATX_Init(const int TaskPrio)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">{</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; int ret = ETX_NOERROR;</span><br style="font-family: courier new,monospace;">
<br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; // On effectue l&#39;ouverture du device </span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; s_DevFpgaTx = rt_dev_open(DEV_FILE_FPGATX, 0);</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; if(s_DevFpgaTx &lt; 0)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; { </span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf(&quot;Impossible d&#39;ouvrir le device\n&quot;);</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -ETX_EXEC;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; }</span><br style="font-family: courier new,monospace;"><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">&nbsp;&nbsp;&nbsp; return ret;</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">}</span><br style="font-family: courier new,monospace;"><b><br>And here is my trace : </b><br><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.061131] Unable to handle kernel paging request for data at address 0x30036f24</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.068793] Faulting instruction address: 0xc0065480</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.073783] Oops: Kernel access of bad area, sig: 11 [#1]</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.080561] PREEMPT TH IPBB</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.083365] Modules linked in: DFPGATX_Main DGPIO_PCA9698</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.088797] NIP: c0065480 LR: c0065d08 CTR: c0064ebc</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.093776] REGS: c06b3c30 TRAP: 0300&nbsp;&nbsp; Not tainted&nbsp; (2.6.23)</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.099535] MSR: 00001032 &lt;ME,IR,DR&gt;&nbsp; CR: 42004424&nbsp; XER: 20000000</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.105684] DAR: 30036f24, DSISR: 20000000</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.109791] TASK = cfe23410[745] &#39;Main_TestDMA&#39; THREAD: c06b2000</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.115638] GPR00: 00000001 c06b3ce0 cfe23410 c03ce0a4 00000000 00000000 c03c0000 c0398980</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.124068] GPR08: c0398980 c03e0000 c0398980 00000000 22002422 1001c37c 0fffa000 00000001</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.132498] GPR16: c03d0000 c0384380 c03c9bc0 00000058 c03b0000 c03dc7d0 c03dc804 c03a0000</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.140928] GPR24: cfc3d0a0 c0398980 cfc3d0d4 c03b0000 00000000 30036f24 30036de0 00000001</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.149538] NIP [c0065480] __shadow_eventcb+0x5c4/0x1424</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.154894] LR [c0065d08] __shadow_eventcb+0xe4c/0x1424</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.160144] Call Trace:</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.162595] [c06b3ce0] [c0065d08] __shadow_eventcb+0xe4c/0x1424 (unreliable)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.169688] [c06b3d20] [c0056db8] detach_ppd+0x38/0x60</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.174855] [c06b3d40] [c0058ad0] cleanup_event+0xd4/0x19c</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.180370] [c06b3d70] [c0049d0c] __ipipe_dispatch_event+0x9c/0x1cc</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.186678] [c06b3dc0] [c001a9b8] mmput+0x6c/0x144</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.191508] [c06b3dd0] [c001ed6c] exit_mm+0xac/0x110</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.196505] [c06b3df0] [c0020194] do_exit+0x164/0x96c</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.201584] [c06b3e30] [c00209d4] do_group_exit+0x38/0xbc</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.207013] [c06b3e40] [c002cafc] get_signal_to_deliver+0x29c/0x4a0</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.213327] [c06b3e80] [c0009150] do_signal+0x44/0x294</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.218502] [c06b3f40] [c0010a84] do_user_signal+0x74/0xc4</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.224027] --- Exception: c00 at 0xffaa228</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.228228]&nbsp;&nbsp;&nbsp;&nbsp; LR = 0xffaa200</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.231286] Instruction dump:</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.234265] 5400103a 7d39002e 81690000 61600001 557c07fe 90090000 2f9f0000 7ffdfb78</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.242082] 419e005c 807be514 3bddfebc 7f84e378 &lt;83fd0000&gt; 8003fffc 3863fffc 7fead278</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">[&nbsp;&nbsp; 35.250083] Fixing recursive fault but reboot is needed!</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">Nbyte 16</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">BufferRec 0x100150b0</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">Nbyte 0</span><br style="font-family: courier new,monospace;">
<span style="font-family: courier new,monospace;">BufferRec (nil)</span><br style="font-family: courier new,monospace;"><span style="font-family: courier new,monospace;">p_HeapMem 0xcf164030</span><br><br><br>We see that Nbyte and BufferRec are reseted. I don&#39;t see why .<br>
Any idea ?<br><br>Thanks in advance,<br><br>Perrine Martignoni<br><br><br><br>

------=_Part_20927_15957656.1206981615131--

