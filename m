From: "Stephan Adler" <stephan.adler@domain.hid>
Date: Wed, 3 Sep 2008 11:06:45 +0200
Message-ID: <000801c90da4$63f46b10$2bdd4130$@adler@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: de
Subject: [Xenomai-help] Xenomai 2.4. and C++ (again)
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hi!

I am currently trying to run some C++ code as an Xenomai task. I wasn't =
aware that there are any problems with C++ until I found out today that =
some function calls in my C++ code break the real-time determinism of =
the task. Xenomai will not be able to interrupt the task although it =
should (as a higher-priority task should become active). The functions =
in question use the std::vector and std::string class.

After I became aware of that behavior I searched a little and found out =
that there is a C++ Wrapper class called Xeno-- and that the problems =
that occurred in my case seem to be well known.

Unfortunately I couldn't find any documentation what C++ calls are known =
to cause such a behavior.=20

As I can not use the Xeno-- Wrapper for several reasons. I wonder if =
some user on this list has some experience with C++ and could provide a =
list of functions / practices to avoid to make C++ code work as =
expected.=20

Some facts about the project:

- I use Xenomai 2.4.3

- Yes - I do call mlockall() before creating any task

- as far as I know no dynamic memory operations are done in the =
functions I use (I am not sure about every detail how std::vector / =
std::string work - but I don't explicitly generate new objects / delete =
them)

Thanks a lot
Stephan Adler




