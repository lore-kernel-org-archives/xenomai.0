Message-ID: <4742E82B.1040000@domain.hid>
Date: Tue, 20 Nov 2007 14:59:07 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <5D63919D95F87E4D9D34FF7748CE2C2AE092AC@ARVMAIL1.mra.roland-man.biz>
In-Reply-To: <5D63919D95F87E4D9D34FF7748CE2C2AE092AC@ARVMAIL1.mra.roland-man.biz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: Philippe Gerum <philippe.gerum@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write error: "Cannot allocate memory ";
 bug or feature ?
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Roderik.Wildenburg@domain.hid
Cc: xenomai@xenomai.org

Roderik.Wildenburg@domain.hid wrote:
>> No more than one block is allocated at any given time in your example.
>> This is expected due to the priority scheme your test 
>> undergoes. In any
>> case, 282 bytes (+ a few bytes message header) should grab 
>> one 512-byte
>> buffer here. For anything below the size of a logical page (4k in
>> 2.3.x), the allocator picks the next power of 2 greater or 
>> equal to the
>> requested size.
> 
> Is it possible that a allocated block remembers the size he is allocated
> for 
> and that the block is just usable for this size even after the block is
> freed ?
>

The block will belong to a 512-byte pool until all the blocks from the
same pool are free, in which case the entire page the pool sits on will
be moved to a free page list, and recycled for blocks of any size.

>> What if you don't set any limit to the queue elements, i.e. passing
>> Q_UNLIMITED instead of 10. Does this change the behaviour?
>>
> 
> This does not help. What helps is increasing the queue size to e.g. 
> MAXLEN*100 = 200000
> (rt_queue_create(&qtest1q, "qtest1q", MAXLEN*100, Q_UNLIMITED, Q_FIFO))
> 
> Could you please try to run my example on your machine, or are you
> shure, that this
> problem is specific to our platform ? Thank you for your help !

This is likely not a platform specific issue. You may want to run your
small test on v2.4-rc6 on your side.

> 
> Best regards
> Roderik 
> 
> MAN Roland Druckmaschinen AG
> Vorsitzender des Aufsichtsrates: Hanno C. Fiedler
> Vorstand: Gerd Finkbeiner (Vorsitzender), Dr. Ingo Koch, Dr. Markus Rall, Paul Steidle    
> Sitz der Gesellschaft: Offenbach am Main, Registergericht: Amtsgericht Offenbach HRB-Nr. 42592    
> USt-Ident-Nr. DE 250200933
> 


-- 
Philippe.

