Received: from sonic305-20.consmr.mail.ir2.yahoo.com (sonic305-20.consmr.mail.ir2.yahoo.com [77.238.177.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84452F37
	for <xenomai@lists.linux.dev>; Wed, 22 Mar 2023 18:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679510507; bh=eaEw5qMaIUpDdYhLwxD06fxBfPWKmxWTEXYFA3ZbaC0=; h=Date:Subject:To:References:Cc:From:In-Reply-To:From:Subject:Reply-To; b=ufXXct3TWK0ANLxwjz73xZK+CSEljulFZDME+oiellf4nd7GaujgeunYV/m1N8nadBu//gCMSoACebyPrzRH/0THZz27KPRSTvWs5TCBtoguiZ8Llqs7uyLwSNREYha/N7q/Z/lx6Feyiq0sLS2KO9f/IIYaLpYV9iFirmbDH80LdDpHlHZMDYixAePz1aKVl9lhHpvOjNg9pgXJN17mwiGfEge3kPVzSsRkp+4QwXmfNOYky3wFH2ugJ5AFu4hHk6tO3wOjV407X5uB7XWIMaYLnHFY3WBsxBeYm8KbMChnYRs2bZXbGoS/PCSEBI8hvimVaa/hIrXHRN0fwvqQKw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679510507; bh=SkjumSoUHyLGpcBfmW8Di5XG/qPQSaRx4+oYb2IzGxA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=d8EFt8ugUBUgxWqr6ygEJqpQHCkZHadw6tj4O3BfJWjm4NhBR7cCn+OuvMLJBxBlOqP2gs10PZ9pnRA+dcNcZ7vpWy0HefplwvcGcYWw7VUza21jIoLj+WFkrWKGrxoI0S7exCTUu7OV6JAsg96/pg+nSjN+lGecPpuU7hIA3CgCCci41HAU0Y05aOwt9yhSb+aiacTrlU4nOJsgqhNmyL6UNEi9jR7EFHQuXC5G8KwUgSmGxA57Czl2SIy66lgXfXeXImQu0qxvLM8vD5gNCpMuBPs0uHOSowVGh94f9HAruhv44fbfg0RAAXbDIELX5VLgXIoRwhSk7xNt7sWC5w==
X-YMail-OSG: 3iFyjv4VM1mvaH2GIPjxhaSRt199drLBOf5rwi0ut4a.coX1o3DmQjqfdrua9lc
 prQdZFeuv5OLyxFDXwm1FtZ5gduOoBU94Hl9l.TQAA1ntEEN816daFZikrCStJdx34Mwguxw9XKs
 XIbGsBQ2GA.nEcDl6NQQNANPT.9Ni5NVeiFsZse44rEevSR63URpfE6VXjgGAAq1y8v1.M0g.t6n
 jAj8fcFlmKmiKkQrTcsHC8rRgwsivZjcEm1qr1ZGKPx1.jA.637akPOW_4JRriqsx.x6NYBKCNbP
 wChvSSlmEI1ytQldXB3RJEtUIueGFZZc_3FQa4Kr0l74CcJ5n5ozZ3q8CkeuVdqPHaHmQd2yWjWX
 ekTDYd7lF9aOwBMhsT_53EMEqWfwokwycHGIv6iVCafuLGn1TvbJwuUuiTNc5Hv3jGLGh7LMQWga
 8RT2xxJA.4D7l7kZvXADsKO4Hd4Xclr4NF.e4fYSsS7AmezVFmo_a8EKjw7cvM1BTxLe9Ss_Jf9g
 qNd6GKK7nxr82Q5MbJGOIxJdubmZIJjxDWPeMb5JtcJB68AAY.BVVA9W9ud6e3e8bLZQFQYhbbJY
 j_rZ76wWKbJTjEkzbAcaIzF9.JRGFT.1UXzDQXoJwRQq3At5k9mk3P5eSjSjA6HLL94LIh_G6SUV
 3LZNaCDJAIviKzZW9wNLBeeHm5b4JQ2RnlmLwC5.teQ9cD5hJLCLDrmezrO1l_Nc6hCt6N3wa26C
 eo7aWTckhPUhcvkY3kG7ftlLK4h9vWR7luEB5xeOTz.ysW3trNm.yE0FbllQrgjSjiE02B84R2.j
 ArdOkqk5ZaF3.nSyYlrvM3CXXx2eCWX4wJh8KCdb_VtNN7nlN9cjlGr5xJxrT0jZYmnIy26pdtFL
 1nePM_bRwmH9kfgHKjNICfvQgdtFaj2p2iZG1RK8WeZjp9Au1AXtjIdADO0oXexB3Ovxf8kG3spD
 dQJhrM_qdFMjqPqeNV8i7BWW2gPBbRhn7OSQC8CTuQGWqDdlBC.ZPq6FXPaQOVkPVvWpsIL6Df8Z
 Vq76sz6_KBBC71.Q78hYt3V.s8wBm.3nKbCdSrxr5tBUnTes2Uw0SfxtaJIPWMmXXzBJcnARWimJ
 4k1U.VzZHBUxbwOVG23iTjHNcTjOsHdYW0GJSmbNvmhD82NPA.8O.m__W5LNz3IXELBLrrHLfzdJ
 jVqvbMH3uOdUjwQln7xG8C2OyiEOt2YqlXsxd.O0Twy1QeZ2e1yECu4vBguMbtusAFcGgpKor60e
 Mr8ByKRFSrFWvMg_Gn8BUeJD_18dYJgZn1gERgEzi7lHtdMYKmEyazeqTB5c90dBcj_OpO0U80Gy
 biU92unq8iSHAI.ApeeSfAKEcT5YI44yGr2w90oM1.r9MRzBFdntSpzTENSf7SAgfZ.RyyAEd.2T
 2zN0TeqOFPdG_FsdUAJQ08uc_gVCK5w_cLfa_rltEXqScd3eQNBqUMsriSqIbZoO9Pj_txK20JmN
 WaqtY0oyHSIG4ToFud1G33KZyxEbQIJbayLddd2rMK8v85_cd_KU.a2N_nb3Aqn2g2oCH9sAkncu
 XTTUjag_SRm2cpGRHpsiDf8t31RQfEJ6VkGgGixnCeYuns2556tl_lirwNqUZbU7WThQsQaDif0O
 UU8UNxZzmXJshLROjS_V7Z9UsqtJMTMSBolP_eGohqOmWRzrWJLIG38Jn4h0HwIoN_gAyVP52X54
 YITORyC_7.dwIrDcy1Co7MmzlW.1gvQFmhI60tZ.J18Y3d3E736AQA7YSjy7y7cw2CHwB0ts2htg
 rmjQ1I2..1L2y7r587Ca6FKA8z9wA1GtBnqGqhoPhW0lkbb0eauM7EwdrMDGv131AvRCSJM4DHAx
 u9EuZ0bIjT5bgRK4WTf48Cq9d0oOb3bA9Q0mtOdLf1rrgV6.OaU1T.PNyVVUVfgOUMfQ04PE91nG
 7treeek21uJS0F1yJ4rRfDIUwSJGF.blXTcJABwzbuy_Ak8RrL6wH.yR44gK2l9VP8wCFhjQaWE1
 68qDbo1b68Z_.xHpfokdDwW4DliUrPovt4xXuinQomnprGMNZO.ieHPr3jbSCkyhkE8B8do5WXN9
 r4XMB6PAzWq8OSYyhpC1A3zs6dm7to1lUUwP013ZxKaJLpFMvquiz.G50uc_DN35n0GLPL.DW67L
 Blks2yLTmH3nmTKooCYPaqgBmzmAz5Yj8sgVPPasgPib9Y53A3i4zcO1k1TXUytUdkAHDclzcp7L
 WVDdnPa1iFkD0
X-Sonic-MF: <mau.salvi@yahoo.com>
X-Sonic-ID: 18211f7c-3773-4b6e-b233-14ee00dd4854
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.ir2.yahoo.com with HTTP; Wed, 22 Mar 2023 18:41:47 +0000
Received: by hermes--production-ir2-5b7d458747-79jv4 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e99c0c3ca5859e755ad2f74ab50189e3;
          Wed, 22 Mar 2023 18:41:44 +0000 (UTC)
Message-ID: <7140ca72-e72b-9840-d955-259fc620985c@yahoo.com>
Date: Wed, 22 Mar 2023 19:41:43 +0100
Precedence: bulk
X-Mailing-List: xenomai@lists.linux.dev
List-Id: <xenomai.lists.linux.dev>
List-Subscribe: <mailto:xenomai+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:xenomai+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Segfault on exit after commit ec804ffbd "lib/copperplate: Release
 main threadobj on exit"
To: "xenomai@lists.linux.dev" <xenomai@lists.linux.dev>
References: <233902a7-0911-06e8-a54b-dd7a1d568264.ref@yahoo.com>
 <233902a7-0911-06e8-a54b-dd7a1d568264@yahoo.com>
 <645dbe21-4dc6-1449-bf73-ea83165fa4d6@yahoo.com>
 <75e4fb40-027a-7e00-d565-ed765b1739a7@siemens.com>
 <16ada5ce-2bca-4169-05ba-517fe1a57d78@siemens.com>
Content-Language: it-IT
Cc: Jan Kiszka <jan.kiszka@siemens.com>
From: "Mauro S." <mau.salvi@yahoo.com>
In-Reply-To: <16ada5ce-2bca-4169-05ba-517fe1a57d78@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21311 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

Il 21/03/23 19:38, Jan Kiszka ha scritto:
> On 28.02.23 13:51, Jan Kiszka wrote:
>> On 28.02.23 13:10, Mauro S. wrote:
>>> Il 21/02/23 15:13, Mauro S. ha scritto:
>>>> Hi all,
>>>>
>>>> I'm using Xenomai 3.2.2 at commit ec804ffbd, kernel 5.4.228, cobalt
>>>> mode, on a Atom x5-E8000 x86-64.
>>>>
>>>> Since I trarted to use the commit in message, I have a subtle segfault
>>>> when I close my application.
>>>>
>>>> I managed to reduce the case in the simple code attached to the message.
>>>> If you run the script, almost always the
>>>> xeno-test-session-segfault-mainproc generates a segfault at exit.
>>>>
>>>> Analyzing the core, the involved code is always the same:
>>>>
>>>> #0  0x00007ff729498400 in __hash_key () from /usr/lib/libcobalt.so.2
>>>> #1  0x00007ff729498897 in hash_remove () from /usr/lib/libcobalt.so.2
>>>> #2  0x00007ff7294b49ac in syncluster_delobj () from
>>>> /usr/lib/libcopperplate.so.0
>>>> #3  0x00007ff7294ce06d in ?? () from /usr/lib/libalchemy.so.0
>>>> #4  0x00007ff7294b6774 in semobj_destroy () from
>>>> /usr/lib/libcopperplate.so.0
>>>> #5  0x00007ff7294ce216 in rt_sem_delete () from /usr/lib/libalchemy.so.0
>>>> #6  0x0000559ca0298651 in SubDummyFn (arg=<optimized out>) at
>>>> main_proc.c:55
>>>> #7  0x00007ff7294cca0a in ?? () from /usr/lib/libalchemy.so.0
>>>> #8  0x00007ff7294b5ce9 in ?? () from /usr/lib/libcopperplate.so.0
>>>> #9  0x00007ff729494f7e in ?? () from /usr/lib/libcobalt.so.2
>>>> #10 0x00007ff729461ea4 in start_thread (arg=<optimized out>) at
>>>> pthread_create.c:477
>>>> #11 0x00007ff72937859f in clone () at
>>>> ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>>>>
>>>> Reverting the commit in object the segfault disappears.
>>>>
>>>> Applying the commit to 3.1 branch results in the same problem.
>>>>
>>>> Seems to be a corruption of the session memory shared between
>>>> processes caused by the atexit() callback introduced by the commit.
>>>>
>>>> Some notes:
>>>> - seems that it depends on when the xeno-test-session-segfault-secproc
>>>> exits: if exit happens during the SubDummy tasks start, the segfault
>>>> is generated, otherwise no
>>>> - seems to be related with the number of calls of the
>>>> xeno-test-session-segfault-secproc: with only one call (change i == 2
>>>> with i == 1 at main_proc.c:139 and remove one call in the script), the
>>>> problem does not happen
>>>>
>>>> Thanks in advance, regards.
>>>>
>>>
>>> Hi all,
>>>
>>> just a kind ping.
>>>
>>> Is there anything I can do to try to solve this problem / do you have
>>> some indications?
>>>
>>> Thanks in advance, regards
>>>
>>
>> Sorry, the original email didn't make it to my inbox, but I see it now
>> in the archives. Will try to have a look but would also welcome if
>> someone else can debug deeper.
>>
> 
> Finally found time to debug. This seems to resolve the issue:
> 
> diff --git a/lib/copperplate/threadobj.c b/lib/copperplate/threadobj.c
> index 6808bcf164..db18f4ffa3 100644
> --- a/lib/copperplate/threadobj.c
> +++ b/lib/copperplate/threadobj.c
> @@ -1773,7 +1773,10 @@ int threadobj_set_schedprio(struct threadobj *thobj, int priority)
>   #ifdef CONFIG_XENO_PSHARED
>   static void main_exit(void)
>   {
> -	threadobj_free(threadobj_current());
> +	struct threadobj *thobj = threadobj_current();
> +
> +	sysgroup_remove(thread, &thobj->memspec);
> +	threadobj_free(thobj);
>   }
>   #endif
>   
> 
> Can you confirm this? I hope we are not missing more things. Needs a
> second check.
> 
> Jan
> 

Hi Jan,

thank you very much. I confirm that this patch fixes the problem.

Thanks again, best regards

-- 
Mauro S.

