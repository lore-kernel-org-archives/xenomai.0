Subject: Re: [RFC PATCH] cobalt: Allow tasks with non-locked memory
References: <20190529210559.20860-1-richard@nod.at>
 <64455108-2e8b-146c-15f9-e3a98030f0dc@web.de>
 <1041770102.74313.1559219392398.JavaMail.zimbra@nod.at>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <397cec80-016a-fc7c-3dac-fdce1e6b5e62@web.de>
Date: Thu, 30 May 2019 15:52:26 +0200
MIME-Version: 1.0
In-Reply-To: <1041770102.74313.1559219392398.JavaMail.zimbra@nod.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Richard Weinberger <richard@nod.at>
Cc: xenomai@xenomai.org

On 30.05.19 14:29, Richard Weinberger wrote:
> ----- Urspr=C3=BCngliche Mail -----
>> Why not simply installing a signal handler in the application that swal=
lows this
>> reason for SIGDEBUG when it's under libsanitizer controller? Or setting=
 the
>> whole signal on ignore?
>
> Simply because I was not sure whether I'm allowed to steal SIGDEBUG from=
 Xenomai
> since it installs its own signal handler.
> If installing my own handler is the preferred way, I'm happy. One patch =
less to
> carry around. :-)

libcobalt only installs a fallback handler that does reporting. There is n=
o
issue adding your own. Rather, it's the normal pattern when the applicatio=
n
wants to react on the various debug reasons.

Jan

