Message-ID: <578d7069180450a8956b7f4d340cb290.squirrel@127.0.0.1>
In-Reply-To: <CA+dLyOWb+V9yCf6CBU_y3EQL_MeKDCJZNvAdf0ah=J9SLkZOYw@mail.gmail.com>
References: <CA+dLyOXPdSs81MZgEjxuCtc9xRKuHkDkFJyF5sLvRaa4SOSzhg@mail.gmail.com>
	<7f61eb0b96dd415b4fe11a855c310b8b.squirrel@127.0.0.1>
	<CA+dLyOWb+V9yCf6CBU_y3EQL_MeKDCJZNvAdf0ah=J9SLkZOYw@mail.gmail.com>
Date: Mon, 16 Sep 2013 19:29:18 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Building a RTDM driver
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Seong-hyeon Kim <zedoul@gmail.com>
Cc: xenomai@xenomai.org


Seong-hyeon Kim wrote:
>> so, you need to use the xeno-config which corresponds to the ARM
> installation
>
> No, there are only one xenomai installation. I am sure and actually that's
> what I really ask.
>
> I would like to change my question, "how can I install xenomai arm-version
> ?"
>
> What I really suspicious about is "./configure --prefix=/usr/xenomai
> --host=arm" this command. I mean it's not documented so I have to guess.

I does not really need to be documented since it is a regular configure
script produced with GNU autoconf. But it happens to be documented:

http://www.xenomai.org/documentation/xenomai-2.6/html/README.INSTALL/#_cross_compilation

-- 
                                              Gilles


