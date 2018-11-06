Subject: Re: Kernel oops during rtnet loopback usage on x86_64 (e1000e)
References: <CAOuPNLg60S+am654fq55vTMoFV1=PfMp3as5MZtt5BHUacFRBQ@mail.gmail.com>
 <2ee8fa04-7ad4-58d5-603b-1d41ad2533ec@siemens.com>
 <CAOuPNLiE-Fy3LJrozgsLE9ga0ibC+GOSHO6ciJppU_bnZtbx0g@mail.gmail.com>
 <73a5c9f6-5014-5113-1ddd-2fcf974273bb@siemens.com>
 <CAOuPNLjuB53ovnEBijNSqrgsKYcSGjLM-L=J4mfbRogwo_5kVA@mail.gmail.com>
 <CAOuPNLh2C8b1KC5D6+Lws_1UA0o0Sp_BaPb3mUTyebUPq_EduA@mail.gmail.com>
 <CAOuPNLiCfmUrDMWyX=N37hVJTBDEqwOtoOr1srf-55ks1qms+w@mail.gmail.com>
 <513744ad-f8fe-d54e-0618-fad492ed5bff@siemens.com>
 <5f46f00c-f09b-7439-93cf-4ff2a0343974@siemens.com>
 <6da8a3e2-7a76-afb2-c46c-7c173a8e444c@siemens.com>
 <9d89227b-fea0-be7c-7e50-c68dccf80053@xenomai.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <c83d2fbd-086d-d6de-86cf-eaee4d041f02@siemens.com>
Date: Tue, 6 Nov 2018 19:57:52 +0100
MIME-Version: 1.0
In-Reply-To: <9d89227b-fea0-be7c-7e50-c68dccf80053@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>, Pintu Kumar <pintu.ping@gmail.com>, Greg Gallagher <greg@embeddedgreg.com>
Cc: "Xenomai@xenomai.org" <xenomai@xenomai.org>

On 04.11.18 17:17, Philippe Gerum wrote:
> On 6/21/18 4:57 PM, Jan Kiszka wrote:
>> On 2018-06-21 15:41, Jan Kiszka wrote:
>>> On 2018-06-21 13:55, Jan Kiszka wrote:
>>>> On 2018-06-21 13:20, Pintu Kumar wrote:
>>>>> Dear Jan, Greg,
>>>>>
>>>>> Is there any pointer about this issue?
>>>>> This is blocking my next work..
>>>>
>>>> Does this solve the issue AND still generate valid UDP checksums (please
>>>> check with wireshark or against a normal networking stack?
>>>>
>>>> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
>>>> index 8e80d3e0b..bb0b0fc12 100644
>>>> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
>>>> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
>>>> @@ -556,18 +556,17 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
>>>>      if (offset)
>>>>  	    return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
>>>>  
>>>> -    /* Checksum of the complete data part of the UDP message: */
>>>> -    for (i = 0; i < ufh->iovlen; i++) {
>>>> -            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
>>>> -                                       ufh->wcheck);
>>>> -    }
>>>> -
>>>>      ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
>>>>  			      to + sizeof(struct udphdr),
>>>>  			      fraglen - sizeof(struct udphdr));
>>>>      if (ret)
>>>>  	    return ret;
>>>>  
>>>> +    /* Checksum of the complete data part of the UDP message: */
>>>> +    ufh->wcheck = csum_partial(to + sizeof(struct udphdr),
>>>> +			       fraglen - sizeof(struct udphdr),
>>>> +			       ufh->wcheck);
>>>> +
>>>>      /* Checksum of the udp header: */
>>>>      ufh->wcheck = csum_partial((unsigned char *)ufh,
>>>>  			       sizeof(struct udphdr), ufh->wcheck);
>>>>
>>>
>>> This was definitely wrong. Here is another try:
>>>
>>> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
>>> index 8e80d3e0b..6cf1d369e 100644
>>> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
>>> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
>>> @@ -549,6 +549,7 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
>>>                            unsigned int offset, unsigned int fraglen)
>>>  {
>>>      struct udpfakehdr *ufh = (struct udpfakehdr *)p;
>>> +    unsigned int datalen = 0;
>>>      int i, ret;
>>>  
>>>  
>>> @@ -556,18 +557,18 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
>>>      if (offset)
>>>  	    return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
>>>  
>>> -    /* Checksum of the complete data part of the UDP message: */
>>> -    for (i = 0; i < ufh->iovlen; i++) {
>>> -            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
>>> -                                       ufh->wcheck);
>>> -    }
>>> -
>>>      ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
>>>  			      to + sizeof(struct udphdr),
>>>  			      fraglen - sizeof(struct udphdr));
>>>      if (ret)
>>>  	    return ret;
>>>  
>>> +    /* Checksum of the complete data part of the UDP message: */
>>> +    for (i = 0; i < ufh->iovlen; i++)
>>> +	    datalen += ufh->iov[i].iov_len;
>>> +    ufh->wcheck = csum_partial(to + sizeof(struct udphdr), datalen,
>>> +			       ufh->wcheck);
>>> +
>>>      /* Checksum of the udp header: */
>>>      ufh->wcheck = csum_partial((unsigned char *)ufh,
>>>  			       sizeof(struct udphdr), ufh->wcheck);
>>>
>>
>> OK, this won't work either if fraglen < datalen. We have to rework this
>> more fundamentally.
>>
>> As a workaround, run the kernel with nosmap.
>>
>> Jan
>>
> 
> There is no point in debugging the splash with UDP until this one is addressed since running with nosmap won't be acceptable in many cases, so I took a stab at fixing this issue first. This fix is somewhat ugly, but a clean solution would involve reworking the entire handling of fragmented packets, so let's see if the logic is right first. Comments and testing welcome:
> 
> diff --git a/kernel/drivers/net/stack/ipv4/udp/udp.c b/kernel/drivers/net/stack/ipv4/udp/udp.c
> index 8e80d3e0b..44616269f 100644
> --- a/kernel/drivers/net/stack/ipv4/udp/udp.c
> +++ b/kernel/drivers/net/stack/ipv4/udp/udp.c
> @@ -538,6 +538,7 @@ struct udpfakehdr
>      struct iovec *iov;
>      int iovlen;
>      u32 wcheck;
> +    size_t rawlen;
>  };
>  
>  
> @@ -549,24 +550,42 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
>                            unsigned int offset, unsigned int fraglen)
>  {
>      struct udpfakehdr *ufh = (struct udpfakehdr *)p;
> -    int i, ret;
> -
> +    void *ckdata, *tmp = NULL;
> +    size_t cklen, len, iovsz;
> +    struct iovec *tmpiov;
> +    int ret;
>  
>      // We should optimize this function a bit (copy+csum...)!
>      if (offset)
> -	    return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen, to, fraglen);
> -
> -    /* Checksum of the complete data part of the UDP message: */
> -    for (i = 0; i < ufh->iovlen; i++) {
> -            ufh->wcheck = csum_partial(ufh->iov[i].iov_base, ufh->iov[i].iov_len,
> -                                       ufh->wcheck);
> +	    return rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
> +				       to, fraglen);
> +
> +    len = fraglen - sizeof(struct udphdr);
> +    if (len < ufh->rawlen) {
> +	    iovsz = sizeof(*tmpiov) * ufh->iovlen;
> +	    tmp = xnmalloc(ufh->rawlen + iovsz);
> +	    if (tmp == NULL)
> +		    return -ENOMEM;
> +	    tmpiov = tmp;
> +	    memcpy(tmpiov, ufh->iov, iovsz);
> +	    ckdata = tmp + iovsz;
> +	    cklen = ufh->rawlen;
> +	    ret = rtnet_read_from_iov(ufh->fd, tmpiov, ufh->iovlen,
> +				      ckdata, cklen);
> +	    if (ret)
> +		    goto out;
> +	    memcpy(to + sizeof(struct udphdr), ckdata, len);
> +    } else {
> +	    ckdata = to + sizeof(struct udphdr);
> +	    cklen = len;
> +	    ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
> +				      ckdata, cklen);
> +	    if (ret)
> +		    goto out;
>      }
>  
> -    ret = rtnet_read_from_iov(ufh->fd, ufh->iov, ufh->iovlen,
> -			      to + sizeof(struct udphdr),
> -			      fraglen - sizeof(struct udphdr));
> -    if (ret)
> -	    return ret;
> +    /* Checksum of the complete data part of the UDP message: */
> +    ufh->wcheck = csum_partial(ckdata, cklen, ufh->wcheck);
>  
>      /* Checksum of the udp header: */
>      ufh->wcheck = csum_partial((unsigned char *)ufh,
> @@ -580,7 +599,11 @@ static int rt_udp_getfrag(const void *p, unsigned char *to,
>  
>      memcpy(to, ufh, sizeof(struct udphdr));
>  
> -    return 0;
> +out:
> +    if (tmp)
> +	    xnfree(tmp);
> +
> +    return ret;
>  }
>  
>  
> @@ -682,9 +705,10 @@ ssize_t rt_udp_sendmsg(struct rtdm_fd *fd, const struct user_msghdr *msg, int ms
>      ufh.uh.len    = htons(ulen);
>      ufh.uh.check  = 0;
>      ufh.fd        = fd;
> -    ufh.iov       = msg->msg_iov;
> +    ufh.iov       = iov;
>      ufh.iovlen    = msg->msg_iovlen;
>      ufh.wcheck    = 0;
> +    ufh.rawlen    = len;
>  
>      err = rt_ip_build_xmit(sock, rt_udp_getfrag, &ufh, ulen, &rt, msg_flags);
> 
> 

Nasty, very nasty. That dynamic allocation could easily cause a performance
regression for existing users.

For my memory: The smap-trigger is doing csum_partial on a userspace buffer,
right? So we would need a user-safe csum_partial. I think the kernel does that...

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

