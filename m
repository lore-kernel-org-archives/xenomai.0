Date: Thu, 30 May 2019 14:29:52 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1041770102.74313.1559219392398.JavaMail.zimbra@nod.at>
In-Reply-To: <64455108-2e8b-146c-15f9-e3a98030f0dc@web.de>
References: <20190529210559.20860-1-richard@nod.at>
 <64455108-2e8b-146c-15f9-e3a98030f0dc@web.de>
Subject: Re: [RFC PATCH] cobalt: Allow tasks with non-locked memory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: xenomai@xenomai.org

----- Urspr=C3=BCngliche Mail -----
> Why not simply installing a signal handler in the application that swallo=
ws this
> reason for SIGDEBUG when it's under libsanitizer controller? Or setting t=
he
> whole signal on ignore?

Simply because I was not sure whether I'm allowed to steal SIGDEBUG from Xe=
nomai
since it installs its own signal handler.
If installing my own handler is the preferred way, I'm happy. One patch les=
s to
carry around. :-)

Thanks,
//richard

