Message-ID: <50DC9C51.9090300@antcom.de>
Date: Thu, 27 Dec 2012 20:06:57 +0100
From: Roland Stigge <stigge@antcom.de>
MIME-Version: 1.0
References: <50CD8E87.2070906@xenomai.org>
	<201212170945.47992.leo@alaxarxa.net> <50CEFB24.9000306@antcom.de>
	<201212171453.44318.leo@alaxarxa.net>
In-Reply-To: <201212171453.44318.leo@alaxarxa.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] next xenomai release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Cc: xenomai@xenomai.org

On 17/12/12 14:53, Leopold Palomo-Avellaneda wrote:
> A Dilluns 17 Desembre 2012, Roland Stigge va escriure:
>> On 12/17/2012 09:45 AM, Leopold Palomo-Avellaneda wrote:
>>> there's a bug, and I must admit that I don't know if it's deliberated (*) 
> or 
>>> not.  This bug comes from some time ago. In the /ksrc/arch/x86/patches 
>>> directory, there's a patch for the 3.2.21 kernel:
>>>
>>> ipipe-core-3.2.21-x86-1.patch
>>>
>>> this patch, in the build process is not included in the root directory: 
> the 
>>> /scripts/prepare-patch.sh script executes:
>>>
>>> find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-*.patch" 
>>>
>>> that is incorrect because the ipipe-core* patch is not found. The correct 
> one 
>>> would be:
>>>
>>> ----------------------------------------------------------------
>>> $ diff -u xenomai-2.6.git/scripts/prepare-patch.sh xenomai-
>>> head/scripts/prepare-patch.sh 
>>> --- xenomai-2.6.git/scripts/prepare-patch.sh	2012-11-06 
> 11:17:56.722698342 
>>> +0100
>>> +++ xenomai-head/scripts/prepare-patch.sh 	2012-12-17 
> 09:23:31.912258850 
>>> +0100
>>> @@ -148,7 +148,7 @@
>>>  
>>>  cd $xenomai_root
>>>  
>>> -find $xenomai_root/ksrc/ -name "*ipipe*$supported_arch-*.patch" |
>>> +find $xenomai_root/ksrc/ -name "adeos-ipipe-2.6.*-$supported_arch-
> *.patch" |
>>>  while read f ; do
>>>  
>>>      file=`basename $f`
>>>
>>> ----------------------------------------------------------------
>>
>> I guess this is a reverse patch?
> 
> :-)
> 
> yes, the order is inverse. Sorry.

OK, should be fixed. Can't find the change in xenomai 2.6.2, unfortunately.

Roland

