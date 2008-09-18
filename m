Message-ID: <48D264B6.6080504@domain.hid>
Date: Thu, 18 Sep 2008 16:24:54 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <mailman.1448.1221743175.22433.adeos-main@gna.org>	
	<217b7eb20809180614u28d04ef8vc63fadb0b7db1ae9@domain.hid>	
	<48D255E0.7000603@domain.hid>
	<217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
In-Reply-To: <217b7eb20809180722w423f78b2qb4d7db0bfb248953@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Adeos-main] adeos-ipipe-2.6.19-arm-1.7-00 on iMX31: init
 doesn't complete!
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: </public/adeos-main>
List-Post: <mailto:adeos-main@gna.org>
List-Help: <mailto:adeos-main-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
To: Hank <hank007@domain.hid>
Cc: adeos-main@gna.org

Hank wrote:
> On 9/18/08, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:
>> Hank wrote:
>>> Hello Guys,
>>> I'm porting xenomai to Freescale iMX31 processor (on iMX31 LiteKit) as
>> per
>>> porting guidelines. In the first phase, applied
>>> adeos-ipipe-2.6.19-arm-1.7-00 patch found in xenomai-2.4.4 to kernel
>>> 2.6.19.2 and have implemented required machine specific code. Everything
>>> went smooth and after fixing a few bugs, kernel booted but with a problem
>> -
>>> init doesn't complete. Following are last few kernel boot log messages:
>>>
>>>
>>> Looking up port of RPC 100003/2 on 192.168.1.25
>>> Looking up port of RPC 100005/1 on 192.168.1.25
>>> VFS: Mounted root (nfs filesystem).
>>> Freeing init memory: 120K
>> Since you are booting via NFS, wireshark may help ?
>>
>> Do you have the same problem if you disable support for VFP ?
>>
>> --
>>                                                 Gilles.
> 
> Thanks Gilles.
> 
> I've tried everything. Wireshark shows NFS read requests being issued and
> busybox etc. being sent back. Already played with VFP without any luck!

And the advice in the "tips and tricks" section of the howto ?

-- 
                                                 Gilles.

