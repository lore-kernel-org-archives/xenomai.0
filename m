MIME-Version: 1.0
In-Reply-To: <CAOuPNLhC=f01Fa-fZ9SFCsroBq14m9059PMFe9he9Jd_m3p=5g@mail.gmail.com>
References: <CAOuPNLhC=f01Fa-fZ9SFCsroBq14m9059PMFe9he9Jd_m3p=5g@mail.gmail.com>
From: Pintu Kumar <pintu.ping@gmail.com>
Date: Wed, 28 Mar 2018 17:46:24 +0530
Message-ID: <CAOuPNLhD1wJTuTfO-NxC6FvZfZf_JZ_gp=4HY0maR_DuzDp0Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Xenomai] Debug prints inside xenomai library code
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

Any clue on this one?
How to add our own debug printf statements inside xenomai library
function?

Thanks,
Pintu

On Tue, Mar 27, 2018 at 10:08 PM, Pintu Kumar <pintu.ping@gmail.com> wrote:
> Hi,
>
> How to add our own debug printf statements inside xenomai library
> function, in order to debug something. ?
> When I add some printf/rt_printf/fprintf(stderr) statements, it never
> get printed on console.
> We even tried with --enable-debug=full flag but it did not help.
>
> It looks like standard input/output calls are disabled.
> If there is any option to enable it, please let me know.
>
>
> Thanks,
> Pintu

