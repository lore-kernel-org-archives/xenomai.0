From: Gabriel Dinse <gabriel_dinse@hotmail.com>
Subject: =?Windows-1252?Q?error:_implicit_declaration_of_function_=91=5F=5FOPEN=5F?=
 =?Windows-1252?Q?NEEDS=5FMODE=92?=
Date: Mon, 28 Dec 2020 15:37:22 +0000
Message-ID: <SN6PR08MB5661723370520CE8725FE0D193D90@SN6PR08MB5661.namprd08.prod.outlook.com>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello, I=92m getting the following error when doing:
~/xenomai-3/build$ make install

[=85 MORE OUTPUT ...]
make[3]: Entering directory '/home/gabriel/xenomai-3/build/lib/cobalt'
  CC       libcobalt_la-rtdm.lo
../../../lib/cobalt/rtdm.c: In function =91__cobalt___open_2=92:
../../../lib/cobalt/rtdm.c:104:2: error: implicit declaration of function =
=91__OPEN_NEEDS_MODE=92
[-Werror=3Dimplicit-function-declaration]
  if (__OPEN_NEEDS_MODE(oflag)) {
  ^
cc1: all warnings being treated as errors
make[3]: *** [Makefile:721: libcobalt_la-rtdm.lo] Error 1
make[3]: Leaving directory '/home/gabriel/xenomai-3/build/lib/cobalt'
make[2]: *** [Makefile:838: install-recursive] Error 1
make[2]: Leaving directory '/home/gabriel/xenomai-3/build/lib/cobalt'
make[1]: *** [Makefile:428: install-recursive] Error 1
make[1]: Leaving directory '/home/gabriel/xenomai-3/build/lib'
make: *** [Makefile:461: install-recursive] Error 1

~/xenomai-3/build$


What can be done in this case?
