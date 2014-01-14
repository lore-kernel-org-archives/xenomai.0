Message-ID: <52D57C33.2050908@siemens.com>
Date: Tue, 14 Jan 2014 19:04:35 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
MIME-Version: 1.0
References: <CA+6vZpS6Mw7rfvHnNBkB-9Jd9C-UUjRJ_hD6Ket_f__8F8iaLg@mail.gmail.com>
 <52D531E4.4040407@xenomai.org>
 <CA+6vZpREPx9H7TxKBniP-TKOs5oo_MfEnc+a-JCRBtjUirsLGQ@mail.gmail.com>
In-Reply-To: <CA+6vZpREPx9H7TxKBniP-TKOs5oo_MfEnc+a-JCRBtjUirsLGQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] filter ipipe tracing
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: David <david35k@gmail.com>, Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: xenomai@xenomai.org

On 2014-01-14 18:30, David wrote:
> OK thanks, it helps to reduce by two factor (div 2) the number of trace per
> milliseconds ; more importantly is CPU usage lowered from 100% down to 50%.
> On a trace of 100000 points, i reached 250ms. 25% of these tracepoints are
> __ipipe_syscall_root+xxx that does not mean anything to me, but all
> syscalls, scheduling decisions and interrupts are visible.
> 
> The resulting trace contains tracepoints on the current CPU that activates
> the trace freeze. Is there a way to activate the simultaneous trace capture
> on two+ cores ?
> 
> I see trace_mark(...info...) in the Xenomai code. I don't think this info
> is displayed in ipipe trace, am I wrong ?

No, trace_mark are dead remainders of LTTng support. I'm slowly
converting them to ftrace tracepoints that you can then retrieve and
visualize with standard tools. It's an x86-64-only endeavor so far,
artifacts can be found in [1] for Xenomai 2 (on maintenance now). For
Xenomai 3, I didn't push anything yet.

Jan

[1] http://git.xenomai.org/xenomai-jki.git/log/?h=queues/ftrace

-- 
Siemens AG, Corporate Technology, CT RTC ITP SES-DE
Corporate Competence Center Embedded Linux

