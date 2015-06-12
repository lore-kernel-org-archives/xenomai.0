From: "Lopes, Alexandre" <alexandre.lopes.ext@zeiss.com>
Date: Fri, 12 Jun 2015 07:54:38 +0000
Message-ID: <79A9E4882C44D44FA53B5AB15E6198011385D47B@ADEERL01SMS001.cznet.zeiss.org>
References: <79A9E4882C44D44FA53B5AB15E6198011385C369@ADEERL01SMS001.cznet.zeiss.org>
 <b692bb78ab6f887dfd41f71655a0a205.squirrel@sourcetrek.com>
 <44y4jq71ku.fsf@be-well.ilk.org>
 <650830a42485b39f0a0443dcb4c5c962.squirrel@sourcetrek.com>
 <79A9E4882C44D44FA53B5AB15E6198011385D400@ADEERL01SMS001.cznet.zeiss.org>
 <44oakm9mql.fsf@be-well.ilk.org>
In-Reply-To: <44oakm9mql.fsf@be-well.ilk.org>
Content-Language: de-DE
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Xenomai] init failed code -19 on Cyclone V SoC
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Lowell Gilbert <kludge@be-well.ilk.org>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

-----Urspr=FCngliche Nachricht-----
Von: Lowell Gilbert [mailto:kludge@be-well.ilk.org]=20
Gesendet: Donnerstag, 11. Juni 2015 19:30
An: Lopes, Alexandre
Cc: Gilles Chanteperdrix; Lowell Gilbert; xenomai@xenomai.org
Betreff: Re: AW: [Xenomai] init failed code -19 on Cyclone V SoC

> The Cyclone V has a timer block external to the Cortex A9 as well, if I=20
remember correctly.

Yes, you're right. There are four external timers available, which could=20
also be used in this case and are already registered on the DTS:

timer0: timer0@ffc08000 {
	compatible =3D "snps,dw-apb-timer";
	interrupts =3D <0 167 4>;
	reg =3D <0xffc08000 0x1000>;
	clocks =3D <&l4_sp_clk>;
	clock-names =3D "timer";
};

timer1: timer1@ffc09000 {
	compatible =3D "snps,dw-apb-timer";
	interrupts =3D <0 168 4>;
	reg =3D <0xffc09000 0x1000>;
	clocks =3D <&l4_sp_clk>;
	clock-names =3D "timer";
};

timer2: timer2@ffd00000 {
	compatible =3D "snps,dw-apb-timer";
	interrupts =3D <0 169 4>;
	reg =3D <0xffd00000 0x1000>;
	clocks =3D <&osc1>;
	clock-names =3D "timer";
};

timer3: timer3@ffd01000 {
	compatible =3D "snps,dw-apb-timer";
	interrupts =3D <0 170 4>;
	reg =3D <0xffd01000 0x1000>;
	clocks =3D <&osc1>;
	clock-names =3D "timer";
};


> I would expect it to come from Qsys, in the sopcinfo file, but=20
apparently at some point I added it to my board info file instead.

It also doesn't seem to be in DTS contained in the vendor specific Kernel=20
(available from the RocketBoards website), so if you have it, it makes=20
sense that you added it yourself.

Alexandre

