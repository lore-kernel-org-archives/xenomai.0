Message-ID: <545745F1.4070108@xenomai.org>
Date: Mon, 03 Nov 2014 10:08:01 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <94331816.zv1NYeHro4@riemann>
 <208C6975C932E94F86239FEA59CCA632DCD4269B@AUSMXMBX02.mrws.biz>
In-Reply-To: <208C6975C932E94F86239FEA59CCA632DCD4269B@AUSMXMBX02.mrws.biz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Message Pipe services behaviour
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: dietmar.schindler@manroland-web.com, Xenomai@xenomai.org

On 11/03/2014 09:54 AM, dietmar.schindler@manroland-web.com wrote:
>> Von: Steve M. Robbins
>> Gesendet: Mittwoch, 29. Oktober 2014 17:11
>> ...
>> To avoid running through the select/read loop once for each message, our old
>> FIFO-based code opened the file in nonblocking mode and did a read into a buffer
>> that could hold up to 100 messages.  We generally would read 5-7 at a time,
>> not 100, so this proved that the reader could keep up when reading in batches.
>>
>> Using this same technique with the /dev/rtpN end of a Message Pipe never reads
>> more than 1 message.  I tried both blocking and non-blocking modes but got the
>> same result.  So this is my main question: knowing that there are likely many
>> messages in the pipe, how do I read them in a batch?
> 
> As far as I can see, read() from a Xenomai message pipe by design never returns more than one message at a time.

Clearly, but from the description, it seems like pulling all messages in
a loop from a non-blocking file descriptor only returns a single
message, although more messages are pending read, according to FIONREAD.

> --
> Regards,
> Dietmar Schindler
> ________________________________
> manroland web systems GmbH -- Managing Director: Joern Gossé
> Registered Office: Augsburg -- Trade Register: AG Augsburg -- HRB-No.: 26816 -- VAT: DE281389840
> 
> Confidentiality note:
> This eMail and any files transmitted with it are confidential and intended solely for the use of the individual or entity to whom they are addressed. If you are not the intended recipient, you are hereby notified that any use or dissemination of this communication is strictly prohibited. If you have received this eMail in error, then please delete this eMail.
> 
> ! Please consider your environmental responsibility before printing this eMail !
> ________________________________
> _______________________________________________
> Xenomai mailing list
> Xenomai@xenomai.org
> http://www.xenomai.org/mailman/listinfo/xenomai
> 


-- 
Philippe.

