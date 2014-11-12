Date: Wed, 12 Nov 2014 21:16:02 +0530 (IST)
From: mayank.chopra@smartplayin.com
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-ID: <1415807162.916828670@apps.rackspace.com>
Subject: [Xenomai] =?utf-8?q?Feasibility=3A_Xenomai_support/integration_on?=
 =?utf-8?q?_msm_targets_=28APQ8060_dragonboard=29?=
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi Experts,=0A=0AIts been a day exploring whether Xenomai is/could be suppo=
rted on msm based chipsets specifically APQ8060. I could not find much supp=
ort for msm platforms, so putting up this request to help me understand wha=
t all it takes to support Xenomai on these platforms.=0AGoing by the portin=
g guide, it seems Xenomai is tightly coupled with ARM instruction set as we=
ll as ARM architecture versions. Appreciate if someone can help me answer b=
elow queries:=0A1. Does Xenomai support Krait CPU architecture which msm ch=
ipsets like APQ8060 are based on?=0A2. I am looking for kernel 3.0 (customi=
zed to the target) support. I got below ipipe patches:=0A      adeos-ipipe-=
3.0.13-arm-1.18-05.patch=0A      adeos-ipipe-3.0.13-arm-1.18-09.patch=0A   =
   adeos-ipipe-3.0.36-arm-1.18-11.patch=0A=0ABut, the patches (tried all 3 =
one by one) did not go well, as they ended up in "unexpected end of file in=
 patch" error.=0A=0AI understand it is not so straight forward to apply abo=
ve patches and make it work. I need some guidance to first complete the fea=
sibility part and then jumping on to try support Xenomai on APQ8060 target.=
 Any help is appreciated.=0A=0AThanks,=0AMayank


