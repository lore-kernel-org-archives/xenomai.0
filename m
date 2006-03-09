Message-ID: <4410844A.5040509@domain.hid>
Date: Thu, 09 Mar 2006 20:38:50 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Anybody Has Sample Code of Message Queue
	Performance Measurement in User Space for Xenomai Native Mode?
References: <FA9961D07FD27B4EB6058C0F35F3D0D17CD9A3@domain.hid>
In-Reply-To: <FA9961D07FD27B4EB6058C0F35F3D0D17CD9A3@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: "Wu, John" <John.Wu@domain.hid>
Cc: "Chau, Ngaiman" <Ngaiman.Chau@domain.hid>, xenomai@xenomai.org

Wu, John wrote:
> Hi Philippe,
> 
> Thanks for the information.  Does the message queue API can only be used
> between kernel sapce and user space only?  How about from user space
> task to another user space task? 
> 

Also works. The uniform queue descriptor blurs the kernel/user-space and process 
boundaries. It should be seen as a communication endpoint.

> Regards,
> 
> John
> 
> -----Original Message-----
> From: Philippe Gerum [mailto:rpm@xenomai.org] 
> Sent: Thursday, March 09, 2006 5:06 AM
> To: Wu, John
> Cc: xenomai@xenomai.org; Chau, Ngaiman
> Subject: Re: [Xenomai-core] Anybody Has Sample Code of Message Queue
> Performance Measurement in User Space for Xenomai Native Mode?
> 
> Wu, John wrote:
> 
>>We are in the process of calibrating Xenomai native API message queue 
>>performance  in user space application.  Does anybody has sample code 
>>to share with us?
>>
>>
> 
> 
> Have a look at ksrc/skins/native/snippets/msg_queue.c.
> 
> 
>>----------------------------------------------------------------------
>>--
>>
>>_______________________________________________
>>Xenomai-core mailing list
>>Xenomai-core@domain.hid
>>https://mail.gna.org/listinfo/xenomai-core
> 
> 
> 


-- 

Philippe.

