Date: Mon, 18 Mar 2019 08:08:14 -0500 (CDT)
From: Per Oberg <pero@wolfram.com>
Message-ID: <296024002.357572.1552914494416.JavaMail.zimbra@wolfram.com>
Subject: [e1000e porting] Unable to send one frame?
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
To: xenomai <xenomai@xenomai.org>


On Mon Nov 5 03:43:49 CET 2018 limingyu wrote:
> Hello,
>=20
> I=E2=80=98m recently work with Xenomai and RTnet,
>=20
> and I found that rt_e1000e driver didn't goes
>=20
> well with the my computer(As my computer
>=20
> uses I219-V2 Ethernet adapter), so I just try to
>=20
> work it out.
>=20
> I use the linux-4.9.51 as my kernel, and ported the
>=20
> intel e1000e driver to the RTnet now. And I have
>=20
> already make it able to send the SYNC frame of
>=20
> TDMA  and Stage 1 Config frame of RTcfg now in
>=20
> the QEMU emulator. But I just found that it's unable
>=20
> to send the Calibration frame back to master from
>=20
> slave side as it's just ONE frame. I can send large
>=20
> number of frame like SYNC and stage 1 frame but
>=20
> can't send just one frame!
>=20
> Does anybody have any idea of this situation?
>=20
> --=20
> =E5=8C=97=E4=BA=AC=E5=87=9D=E6=80=9D=E8=BD=AF=E4=BB=B6=E8=82=A1=E4=BB=BD=
=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E5=9B=9B=E5=B7=9D=E5=88=86=E5=85=AC=E5=
=8F=B8
> =E8=81=94=E7=B3=BB=E4=BA=BA=EF=BC=9A=E6=9D=8E=E6=98=8E=E5=AE=87
> =E8=81=94=E7=B3=BB=E7=94=B5=E8=AF=9D=EF=BC=9A028-65182023-6202
> E-mail: myli at linx-info.com
> =E5=85=AC=E5=8F=B8=E5=9C=B0=E5=9D=80=EF=BC=9A=E6=88=90=E9=83=BD=E5=B8=82=
=E6=AD=A6=E4=BE=AF=E5=8C=BA=E5=A4=A9=E5=BA=9C=E5=A4=A7=E9=81=93=E4=B8=AD=E6=
=AE=B5530=E4=B8=9C=E6=96=B9=E5=B8=8C=E6=9C=9B=E5=A4=A9=E7=A5=A5=E5=B9=BF=E5=
=9C=BA1=E5=8F=B7=E6=A5=BC3402

limingyu

Did you ever get this working ?=20
I'm interested in support for I219 too.

Regards
Per =C3=96berg

