Message-ID: <48BE58B9.3080805@domain.hid>
Date: Wed, 03 Sep 2008 11:28:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <000801c90da4$63f46b10$2bdd4130$@adler@domain.hid>
In-Reply-To: <000801c90da4$63f46b10$2bdd4130$@adler@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai 2.4. and C++ (again)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Stephan Adler <stephan.adler@domain.hid>
Cc: xenomai@xenomai.org

Stephan Adler wrote:
> Hi!
> 
> I am currently trying to run some C++ code as an Xenomai task. I
> wasn't aware that there are any problems with C++ until I found out
> today that some function calls in my C++ code break the real-time
> determinism of the task. Xenomai will not be able to interrupt the
> task although it should (as a higher-priority task should become
> active).

Either your perception is wrong, or this is a bug. Could you provide a
small example exhibiting such behaviour ?

> - as far as I know no dynamic memory operations are done in the
> functions I use (I am not sure about every detail how std::vector /
> std::string work - but I don't explicitly generate new objects /
> delete them)

std::vector and std::string use dynamic allocation without any doubt.

-- 
                                                 Gilles.

