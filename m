Message-ID: <518BC59F.60208@xenomai.org>
Date: Thu, 09 May 2013 17:49:51 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rOMJi4u7sm9+a79aJ2GhhtJY7B5QD0+tVxsN7KoFMqxCw@mail.gmail.com>	<518A5F0C.50403@xenomai.org>	<CAPpP=rNt32NFsF5LhJybpcBRfm33za8kP2tQj+t4Vs9-hkH48w@mail.gmail.com>	<518ABA3D.5070106@xenomai.org>	<CAPpP=rOQm+GBuoB5KuAiAo5nG=HzggXb7CyLaP-SHAwebykPUw@mail.gmail.com>	<518B8C50.2050107@xenomai.org>	<CAPpP=rNkQTDCfRAxpN5wPNK-5R-4gngpxFGUCiqT2T8gwMKJRg@mail.gmail.com>	<518BA407.8020103@xenomai.org>	<CAPpP=rNCxHUfcBS7djmv8i+Er2PpXBdO101LfcxaZswzc9eBnw@mail.gmail.com>	<518BAF44.9060803@xenomai.org>	<CAPpP=rMLPeRAVCpdKQkLVD29pFUj8zPL5JRmTbrJkKEetJJbew@mail.gmail.com>	<CAPpP=rM6BTevvfoV+TT4ej6zkeyzdnY7yN_qVCUPkLFe38EUYA@mail.gmail.com>	<518BB895.3050208@xenomai.org>	<CAPpP=rNFf4qH0JPpR57i5qp1tmHbLb2k8X9qYjn+6dmZb_ckvA@mail.gmail.com>	<518BBFDC.7060102@xenomai.org>	<CAPpP=rOFw32ctFaLGtrPd-L0ZaTR_d38HhLZ9anSrk1tucv-xw@mail.gmail.com>	<518BC2C3.3080004@xenomai.org>
	<CAPpP=rNCqAAiAzTviRxk7Oy1MRO4A6VGk5cJKVSGSa9q_Xp+Fg@mail.gmail.com>
In-Reply-To: <CAPpP=rNCqAAiAzTviRxk7Oy1MRO4A6VGk5cJKVSGSa9q_Xp+Fg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [Posix] I/O multiplexing with select
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 05/09/2013 05:46 PM, alex alex wrote:

>>
>> Ok, could you test the problematic code with the current contents of
>> xenomai git ?
>> git://git.xenomai.org/xenomai-2.6.git
>> branch master
>> --
>>
> 
> OK, but the patch you mentioned :
> http://git.xenomai.org/?p=xenomai-2.6.git;a=commitdiff;h=84b3b4ee50d2e2aa5ebd257a02d330994de674a3;hp=2a29477bbad419f5570e660e90f918c0627c893e
> 
> is already in my xenomai tree.
> Have you done other changes with the pthread_name_set_np ?


No, could you show us a dissassembly of the function strncpy ?(on the
exact kernel which has the bug, if you recompiled the kernel, please
trigger the bug again to get the oops message that corresponds to it).


-- 
                                                                Gilles.

