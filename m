Message-ID: <5135E35A.4020303@xenomai.org>
Date: Tue, 05 Mar 2013 13:21:46 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <512C806F.2020209@hilscher.com>	<512C9E78.1060208@siemens.com>	<512CC5C6.8050204@hilscher.com>	<512CC6A3.1010005@siemens.com>	<512F120A.5060109@hilscher.com>	<512F4005.60000@siemens.com>	<512F48AA.8020601@hilscher.com>	<5130B39C.70300@hilscher.com>
	<513465CF.4030807@hilscher.com>	<51350D5B.6060309@xenomai.org>
	<5135CCDE.5090401@hilscher.com> <5135D667.8060309@siemens.com>
In-Reply-To: <5135D667.8060309@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Hilscher driver for cifX boards
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: xenomai@xenomai.org

On 03/05/2013 12:26 PM, Jan Kiszka wrote:

> On 2013-03-05 11:45, Jerome Poncin wrote:
>> The code with #ifdef DEBUG is also questionable, it will tend to bitrot
>> since nobody will think to enable it.
>>
>> => I disagree with you, it could be helpful if somebody have a problem
>> and want to debug quickly.
>> But I can remove it if it's not standard to xenomai kernel.
> 
> #ifdef DEBUG is widely considered obsolete. If you have debug relevant
> information, tracepoints are much better as they are runtime switchable.
> 
> But to look at a concrete example:
> 
>> +static ssize_t cifx_pci_read(struct rtdm_dev_context *context,
>> +                 rtdm_user_info_t *user_info, void *buf,
>> +                 size_t nbyte)
>> +{
>> +    struct rtdm_device *info = (struct rtdm_device *)context->device;
>> +
>> +    if (nbyte > sizeof(struct io_info)) {
>> +#ifdef DEBUG
>> +        rtdm_printk
>> +            ("cifx rtdm driver error : data user size too big\n");
>> +#endif /* DEBUG */
>> +
>> +        return 0;
> 
> If it is an error, return the proper code (-EINVAL? Or -E2BIG?). That
> will be visible without any driver instrumentation.
> 
>> +    }
>> +
>> +    /* Copy data information for userland */
>> +    if (rtdm_safe_copy_to_user(user_info, buf,
>> +                   ((struct io_info *)info->device_data),
>> +                   nbyte)) {
>> +#ifdef DEBUG
>> +        rtdm_printk
>> +            ("cifx rtdm driver error : can't copy data from driver\n");
>> +#endif /* DEBUG */
> 
> And this is a bug: return -EFAULT. Again, no need for driver
> instrumentation.
> 
>> +    }
>> +
>> +    return nbyte;
>> +}
> 
> ...
> 
>>
>> I think you are not convinced yet that "code is the best documentation"
>>
>> => Yes, you right it's because I worked long time on safety project (for
>> me it's a habit) .
>> Moreover I thunk it could be helpful in an open source project, if
>> somebody want to more easily understand code.
> 
> Non-trivial code is better augmented with comments.


Or better removed and replaced with trivial code...

> However, commenting
> on the obvious is like meaningless chatting. ;)


Yes, IMO, a driver should not be a tutorial for people wanting to write
other drivers, if they need a tutorial, they should look for a tutorial,
not for comments in existing code.

-- 
                                                                Gilles.

