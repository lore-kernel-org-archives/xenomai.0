MIME-Version: 1.0
In-Reply-To: <52D531E4.4040407@xenomai.org>
References: <CA+6vZpS6Mw7rfvHnNBkB-9Jd9C-UUjRJ_hD6Ket_f__8F8iaLg@mail.gmail.com>
 <52D531E4.4040407@xenomai.org>
Date: Tue, 14 Jan 2014 18:30:33 +0100
Message-ID: <CA+6vZpREPx9H7TxKBniP-TKOs5oo_MfEnc+a-JCRBtjUirsLGQ@mail.gmail.com>
From: David <david35k@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] filter ipipe tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

OK thanks, it helps to reduce by two factor (div 2) the number of trace per
milliseconds ; more importantly is CPU usage lowered from 100% down to 50%.
On a trace of 100000 points, i reached 250ms. 25% of these tracepoints are
__ipipe_syscall_root+xxx that does not mean anything to me, but all
syscalls, scheduling decisions and interrupts are visible.

The resulting trace contains tracepoints on the current CPU that activates
the trace freeze. Is there a way to activate the simultaneous trace capture
on two+ cores ?

I see trace_mark(...info...) in the Xenomai code. I don't think this info
is displayed in ipipe trace, am I wrong ?

Regards.


2014/1/14 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>

> On 01/14/2014 01:35 PM, David wrote:
>
>> Dear,
>>
>> I'm actually tracing my Xenomai drivers/syscalls thanks to the ipipe trace
>> facility. Actually, every "ipipe/xenomai/rtdm drivers" procedures are
>> traced. I give a try with 5000 points, I'm able to trace about 5ms of
>> execution. This is already a huge help for some problems but (a) it is too
>> short for my new needs. The performance impact of tracing appears big
>> (about x2 on performance ?), (b) it makes my application instable (100% of
>> CPU usage).
>>
>> (a) Is it possible to trace about 1-10s of execution ? (any hint ?).
>> (b) Could we reduce performance impact for tracing ? I used FTRACE in the
>> past, it was possible to filter the events or procedure names traced but I
>> don't know how to proceed with ipipe tracing.
>>
>
> If you are only interested in the events you generate, then you can
> disable tracing of function entries and exit, and generate the events you
> are interested in with ipipe_trace_special.
>
>
> --
>                                             Gilles.
>
