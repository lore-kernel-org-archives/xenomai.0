Message-ID: <53C7A6FA.5000603@xenomai.org>
Date: Thu, 17 Jul 2014 12:35:38 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <FEB36BE3-3DA6-4594-9064-213B66B059ED@gmail.com>
 <53C65420.6040608@xenomai.org>
 <0106E84F-4693-4A95-8219-298D9E932C17@gmail.com>
In-Reply-To: <0106E84F-4693-4A95-8219-298D9E932C17@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] modprobe cannot find RTDM kernel module during boot
 sequence
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Jaap Kempenaar <janjaapkempenaar@gmail.com>, xenomai@xenomai.org

On 07/17/2014 09:48 AM, Jan Jaap Kempenaar wrote:
> Hello,
> 
> Thank you for your reply.
> 
>> 
>> You should not use kernel 3.2.21, the I-piep patch is known to
>> contain a bug. Please update to a more recent patch.
>> 
> 
> We are trying newer kernel versions, however have not been able yet
> to create one that runs the xeno-test stable.

What happens exactly?

> However, would there be
> a possibility that the issue mentioned here is solved with a newer
> kernel version/adeos patch?

I do not think so, it is just that 3.2.21 has a bug which has been fixed
in more recent versions.

> 
>> Some versions of modprobe try to insmod the module directly first,
>> and if that fails take the dependencies into account. If the module
>> appears in lsmod, I believe you can safely ignore this warning.
> 
> After boot(and login as root), when performing the lsmod, the module
> is also not loaded. However when we perform the "modprobe rt_module"
> then, the module gets loaded properly.

You should try and add "set -x" to the script which loads the modules in
/etc/modules, to have a better understanding of what happens.

-- 
                                                                Gilles.

