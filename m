Subject: Re: rtcansend 32-bit
References: <CA+K1mPGLQ5-B-qrTasdwc_G38cr6T78V0Nip3bEkdD89761ukA@mail.gmail.com>
 <9a0553a5-aa37-a089-54e8-45a59ebf1095@siemens.com>
 <CA+K1mPE4d9qQ2-tT+rDGBR4v__vzrXu2736+JFADco8a6Y7xLQ@mail.gmail.com>
 <87ba187f-5e89-a0f3-10f6-fc14eb5efe21@siemens.com>
 <93290885-9113-dd98-b1df-550604fc6fff@siemens.com>
 <03214e1aeb2ad8c681e63a01fd6051ec3c309aec.camel@siemens.com>
 <CA+K1mPGzCcaxm4qT4vF5kkk2yc5c8mTxq1mJ1Wp6UW6H2ftmuw@mail.gmail.com>
 <8ba75fe52f21b3dc56d261e22282f7ef8bc5b050.camel@siemens.com>
 <CA+K1mPFkjVhKh_28+k7GowYs3mWvHnKiYhPnj4sVb2O0CHbSgg@mail.gmail.com>
 <6e3838fd-7257-2bb6-8eb7-98d569209406@siemens.com>
 <695bc5e8457585912d080386b4a1c39e5330b7b5.camel@siemens.com>
 <CA+K1mPHkRqn8wA=F6zfeQp8nw8twGsxT6n_yEcbS1Vdek9sAPg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <39cfd30c-3b95-b2df-fe2c-3b24062980d6@siemens.com>
Date: Fri, 5 Nov 2021 19:21:35 +0100
MIME-Version: 1.0
In-Reply-To: <CA+K1mPHkRqn8wA=F6zfeQp8nw8twGsxT6n_yEcbS1Vdek9sAPg@mail.gmail.com>
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
To: C Smith <csmithquestions@gmail.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>, "Bezdeka, Florian" <florian.bezdeka@siemens.com>

On 05.11.21 19:14, C Smith wrote:
> Here's an updated patch addressing mentioned issues.
> I've noticed ipc/internal.h re-defines COMPAT_CASE(__op) as well.
> 
> I don't know what gmail is doing to the inline text (this should be
> plain text) so I've also attached a .gz version of the patch.
> 

Please use git send-email against gmail's SMTP server. The attached .gz
version is also incomplete.

Buildroot has a nicely detailed description how to get that ball rolling
(just replace addresses):
https://buildroot.org/downloads/manual/manual.html#submitting-patches

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

