References: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f91caf3e-5b65-298a-1ac6-91697eed90c3@xenomai.org>
Date: Thu, 28 Jun 2018 17:37:45 +0200
MIME-Version: 1.0
In-Reply-To: <008d01d40ef4$aa152ab0$fe3f8010$@sepro-group.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Assertion current-magic 0 failed
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?Q?St=c3=a9phane_Reichert?= <sreichert@sepro-group.com>, xenomai@xenomai.org

On 06/28/2018 05:28 PM, Stéphane Reichert wrote:
> Hi,
> 
> I am testing the new version 3.0.7 on our system (iMX 6 on 4.1.46 kernel), 
> and I would like to know
> if anybody else encountered this error :
> 
> threadobj.c:1344: threadobj_prologue: Assertion `current->magic == 0' 
> failed.
> 
> I compile the kernel with --enable-pshared --enable 
> registry --enable-debug=full.
> 
> Here is a backtrace I get on the debug signal callback:
> 
> # Mode switch (reason: triggered fault), aborting. Backtrace:
> Retrieve backtrace...
> ./tests_integration_lib_ipc(Unable to handle kernel NULL pointer dereference 
> at virtual address 00000004
> 4x180)[0[x01020206000]08l0e0r0+
> ]]/ l*ipbd=39180831/libc.so.,6 (*+p0txe2=50105000)0[00, 
> *ppte=000000000x76ca3150
> 
> /lib/libcopperplate.so.0(syncobj_lIonctke+r0nxa8l4 error: Oops: 17 [#1] 
> PREEMPT SMP ARM
> l0x76Meo1dau7lee8s]
>  i/nlkiebd/in:libcopper pcltarte.so.0(syncluster_fin 
> dcocbmj+0x34)[0x76e18eec]
> /lib/li buaslbc_hfe_mayc.mso.0(al u_serialchemy_bind 
> _uosbbj_efc_te+c0mx98)[0x76e 3ge_1ccd0c]
> nlib/libalchemy.so. 0u(_rett_hheerap_bind+0x30 libcomposite)[0x76e411c 4c]o
>  f/irgofost/libs/lib_ iwplc1.2sxox(init_local_data+0x6 0w)l[c0oxr7e6f1085c]
> /roo mac80211t/libs/li bc_figp8c0.2s1o1(rt_shm_open+ 0rxf7k0i)l[l0x76f10bfc]
>  /tests _filnetxecgarnation_lib_ip wlcore_sdioc[0x12d68]
> dc/il_ihbd/rlci_biamlchemy. suos.b0m(i+s0cx_ai4m4x8)[0x76e43 4c4i8_]h
> ]r/clib/libcoppe udc_corerplate.so. 0c(a+n0_xd8e3v14)[0x76e1a314
> 

It looks like there are two backtraces, one generated from the app in
userland, a second one by the kernel, none of them is readable as they
intermingle.

-- 
Philippe.

