Message-ID: <4E93F79D.70806@domain.hid>
Date: Tue, 11 Oct 2011 10:00:29 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CACFV95JranppM+ZDoqsgjO5nJ-Th2fFAD0HowBSkL-t_wQ-t4w@domain.hid>
	<4E8F1643.1050700@domain.hid>
	<CACFV95LnySGuKP2NQ+BcYk-wuk+S9Gh2iu1Xmqh9VLNsH1Az0w@domain.hid>
	<4E8F2CFA.1070306@domain.hid>
	<CACFV95LX8U8U=UW6EicEjRYSjToSmL9-PPVf=n16GfKW9pLsPg@domain.hid>
	<4E907256.1010707@domain.hid>
	<CACFV95KWbC_ehmHqrh+E_dTfeMzvOabFSNLYe6LDvRWG-_V+6w@domain.hid>
	<4E92B7AC.8040502@domain.hid>
	<CACFV95KO42VMre6dwfrZvO-1NYvV+Z8F-GtLKsdeMJZO1bYqbQ@mail.gmail.com>
	<4E9337AC.60100@domain.hid>
	<CACFV95LQgGvy=KXzCV-peV3ybZJaHiMguNsktQLOBbwqWH2Ydw@domain.hid>
In-Reply-To: <CACFV95LQgGvy=KXzCV-peV3ybZJaHiMguNsktQLOBbwqWH2Ydw@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xenomai: /dev/rtheap is missing (chardev,
 major=10 minor=254) in mini2440
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Siva kumar Balasubramanian <sivakumar.bs@domain.hid>
Cc: xenomai@xenomai.org

On 10/11/2011 07:21 AM, Siva kumar Balasubramanian wrote:
> The patch works, Thank you for fixing this
> 
> Now i was able to build without errors. I got mini2440 booting
> 
> I was able to run xeno-test
> 
> But when i try to test Helloworld program. I found the following libraries
> missing
> 
> error while loading shared libraries: librtdk.so.0: cannot open shared
> object file: No such file or directory

If you intend to run a program with xenomai 2.6.0, you have to compile
it with xenomai 2.6.0.

-- 
                                                                Gilles.

