MIME-Version: 1.0
Sender: mfornero@gmail.com
In-Reply-To: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
References: <CAKS01okfPOzCckUbe+NCfPT3fSqst2JaGpnGG8VaPCwbjvtE_Q@mail.gmail.com>
Date: Tue, 29 Oct 2013 10:16:10 -0400
Message-ID: <CADVgf9n6daP32wfGR+61Ko0m8q=nSD+uNe42PneJ_S5uhg7yyw@mail.gmail.com>
From: Matthew Fornero <mfornero.lists@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [Xenomai] xenomai - zynq - linux-xlxn14.5 - booting halted !
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Anup Kini <akini@synapticon.com>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Oct 29, 2013 at 8:43 AM, Anup Kini <akini@synapticon.com> wrote:
> Hi All,
>
> I am using xenomai-2.6.3 with linux-xlnx-v14.5.
> I have patched the kernel as given in the readme (for Zynq SoC).
>
> My booting stops after the following messages:
>
>
>    1. I-pipe: head domain Xenomai registered.
>    2. Xenomai: hal/arm started.
>    3. Xenomai: scheduling class idle registered.
>    4. Xenomai: scheduling class rt registered.
>    5. Xenomai: real-time nucleus v2.6.3 (Lies and Truths) loaded.
>    6. Xenomai: debug mode enabled.
>    7. Xenomai: starting native API services.
>    8. Xenomai: starting POSIX services.
>    9. Xenomai: starting RTDM services.
>    10. bounce pool size: 64 pages
>
>
> Pastebin link to entire bootlog: http://pastebin.com/jZTHEQU3
>
> <http://pastebin.com/jZTHEQU3>
> Kindly let me know how to proceed with fixing this issue.

Can you post your kernel config?

