Subject: Re: Fwd: Round-Trip Time Requester with Xenomai / RTnet on Beaglebone
 Black
References: <CAEmXcAzOL4M-JRUWgm3mjmz+bQ=nHc-QW5dr-iBc24RXXu5CTg@mail.gmail.com>
 <320b1c56-047f-764f-036a-d3302ddbd0f4@siemens.com>
 <CAEmXcAxuFzE2uQHGMUjBnbgadTTcNU_DwV64uvLPahxxDMKTyQ@mail.gmail.com>
 <be5b28d1-e689-5c60-4d20-2be511ec489a@siemens.com>
 <CAEmXcAxs3O_Hmph-48JArHgCmWSj+wAiffkNCZKiL9uVew6irg@mail.gmail.com>
 <22b6931e-8f7b-0cae-2316-5b278d1186d6@siemens.com>
 <CAEmXcAzzSfT5jVQpM2CidLh-CCJRPt45jJMRq_mmXz0wHFnyXQ@mail.gmail.com>
 <34f86f81-70f4-9b07-26e7-3525bfaf6fcf@siemens.com>
 <CAEmXcAz6p9yg65uigQx6zJyey1nnkmdq8+i1Ou2bT888n-thrg@mail.gmail.com>
 <309d004d-23de-a4a5-7536-4c08e463c556@siemens.com>
 <CAEmXcAzn2jagk3CkTk=5zhuWu4tPWC9hUSSpsCOzmG=Gu4rn4Q@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0cd6d298-cee7-2799-4b61-2b868d742128@siemens.com>
Date: Fri, 7 Jun 2019 12:15:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAEmXcAzn2jagk3CkTk=5zhuWu4tPWC9hUSSpsCOzmG=Gu4rn4Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: danwe <daniel.wenninger92@gmail.com>, xenomai@xenomai.org

On 07.06.19 11:40, danwe wrote:
> I have checked what the generated binary is using.
> E.g. it is using lines like:
> 
> 19: 00008bc8   0 FUNC   GLOBAL DEFAULT UND ioct1@GLIBC_2.4 (3)
> 45: 00008cc4   0 FUNC   GLOBAL DEFAULT UND socket@GLIBC_2.4 (3)
> 
> Does that mean that it is using the non-rt glibc services? If so then I do not 
> understand one thing: the file "raw-ethernet" is a example where it uses the 
> same ioct1@GLIBC and socket@GLIBC but it does not throw the "network is 
> unreachable error".
> But how can I change that it is using the __wrap_socket?

Compare the invoked gcc command line with the output of "xeno-config 
--skin=posix --ldflags". Something is preventing the the required flags make it 
into your build. Also try building manually, to exclude flaws in your buildroot 
environment.

Does "raw-ethernet rteth0" actually work? Or are you calling "raw-ethernet eth0" 
by accident?

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

