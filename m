Message-ID: <16802252.1162217706570.JavaMail.ngmail@domain.hid>
Date: Mon, 30 Oct 2006 15:15:06 +0100 (CET)
From: "M. Koehrer" <mathias_koehrer@domain.hid>
Subject: Re: Re: [Xenomai-help] Results of xenomai's latency test vs. RTAI's
In-Reply-To: <1162208265.4955.17.camel@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_153987_26794380.1162217706568"
References: <1162208265.4955.17.camel@domain.hid>
	<21364954.1162202747823.JavaMail.ngmail@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org, mathias_koehrer@domain.hid
Cc: xenomai@xenomai.org

------=_Part_153987_26794380.1162217706568
Content-Type: multipart/alternative; 
	boundary="----=_Part_153986_1784429.1162217706568"

------=_Part_153986_1784429.1162217706568
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

I have rebuild my system using V2.2.4 of xenomai.
Also, I had a look to reuse the kernel configuration from the 2.4.33 RTAI s=
ystem.
However, the results are more or less the same.
The only kernel module I have loaded is the "tg3" network driver, the chips=
et of the=20
PC (ICH6) is supported by the SMI detection and it is activated.

I have enclosed my kernel configuration, perhaps this can help to identify =
an issue.
I do not have X11 running, it is a text-mode only system that is controlled=
 via telnet from
another PC.

I'll try to do a stress test on the RTAI system as well.

Regards

Mathias

> > I am currently checking XENOMAI (V2.2.3 on a 2.6.17.7 kernel P4) to see=
 if
> I can use it
> > as replacement for a RTAI 3.3-cv application.
> > The first thing I did was to run the latency test in the the xenomai's
> testsuite directory.
> > The results of the worst time latency are really ugly - about 40=B5s!
> > On the very same PC I got a value of about 5=B5s using RTAI 3.3-cv runn=
ing
> the RTAI's
> > user/latency test.
> >=20
> > My question is now: Why can there be such a huge difference between the
> two systems on the very same
> > hardware??
> > Is there a way to improve this value?
> >=20
> > The RTAI system uses a 2.4.33 kernel, the XENOMAI uses the 2.6.17.7
> kernel. Could this
> > be an issue?
> >=20
>=20
> Several issues there:
>=20
> - are you 100% sure that your kernel config file for 2.4.33 is perfectly
> recycled for 2.6.17, e.g. are all latency killer options as listed in
> the TROUBLESHOOTING file really disabled? P4 configurations are
> jitter-prone; some options are know to induce bad latencies.
>=20
> - worst-case figures do not depend on how fast you get them, the latter
> information gives you nothing to interpret from. You may want to stress
> test the box for a longer period of time, using things like e.g. a dd
> loop, and a compilation in the background (dd if=3D/dev/zero of=3D/somefi=
le
> count=3D500 bs=3D1M). "ping" network test is not the worst latency raiser=
,
> actually, under some circumstances, it could even hide some latency
> issues, basically because it favours the code locality in i-cache. Also
> make sure to measure without X-window interaction in both cases; some
> graphic card drivers induce latencies, some don't. YMMV.
>=20
> This said, 40us on a P4 class machine is not an expected value for
> Xenomai/x86. To give you some reference figures, I have a uniprocessor
> 2.8Ghz Xeon box (no HT) performing at 15 us worst-case, and an older
> dual 2.4Ghz Xeon SMP which honours 25 us worst-case in SMP mode. Fact is
> that to get that, I need to disable a number of ACPI options (except
> those which are needed to boot properly in SMP mode), and activate the
> SMI work-around.
>=20
> And above all, a good starting point would be to send your kernel
> configuration file, so that we could discuss about facts. Additionally,
> you may want to upgrade to 2.2.4; 2.2.3 has a FPU issue on some hw.
>=20


--=20
Mathias Koehrer
mathias_koehrer@domain.hid


Viel oder wenig? Schnell oder langsam? Unbegrenzt surfen + telefonieren
ohne Zeit- und Volumenbegrenzung? DAS TOP ANGEBOT JETZT bei Arcor: g=FCnsti=
g
und schnell mit DSL - das All-Inclusive-Paket f=FCr clevere Doppel-Sparer,
nur  44,85 =80  inkl. DSL- und ISDN-Grundgeb=FChr!
http://www.arcor.de/rd/emf-dsl-2
------=_Part_153986_1784429.1162217706568--

------=_Part_153987_26794380.1162217706568
Content-Type: application/octetstream
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=config_linux_2.6.17.7.gz

H4sICOIGRkUAA2NvbmZpZ19saW51eF8yLjYuMTcuNwCUPF1z27iu7/srNLsPp53pR+w4abJzc2do
irJ5LIkqSfljXzRuora+dewcx+42//6ClGRREqnsyUwSCwBJEARBAIT8x29/eOh03D+uj5v79Xb7
4n3Ld/lhfcwfvMf1j9y73+++br796T3sd/86evnD5ggtws3u9Mv7kR92+db7mR+eN/vdn97ww/WH
wacPn4Ag2u88dn/0Li+8wdWfV6M/Ly694cXF9W9//IZZHNBJtry5zi6Hdy/VsyARSqaMk0yEhCSE
ixoHtPVDFKX1w4TEhFOcUYEyP0IWBINuu+DpgtDJVNYIxPE0i9Aqm6I5yRKcBT6usX5E4QGY/8PD
+4ccJHM8HTbHF2+b/wQJ7J+OIIDnenJkCROgEYklCutexpzNSJyxOBORwRONqcxIPAceJllIIyrv
LofFYBO9FlvvOT+enuruQ4ZROAcRURbf/f5+87R5yn+3ITOUSmbIeGHKQqzEnCZqljCrApQwQZdZ
9DklKfE2z95uf1Rjnycg/CzhDBMhMoSxNJu2cdn80tIDjIllaLZDqU+lSXnG0FnxwYrkJEQrywBK
mBxFgcgESzkmd7+fBZNSf2Do0TwytQrjjCUShP8XyQLGMwEfTDZJNCa+T3zLkDMUhmIVCZO8gmXw
38r/mYAsgd8sQUJYup4ymYTppGYz4TSWM0OlTCQJgwzDDjLQSMB00tBQwiCVZGm0SZiJFdOIRMZj
iMbmtCSNVwWNTTvUYCKCid1d1E1EyMYmsdbrcL9+WH/ZwkbaP5zg3/Pp6Wl/ONYaHjE/DYlhAgpA
lsYhQ77JUomANcMV2ipwoCs3hXDhVT+C4/PeaS5dtXBAWNmC8XZ//8Pbrl/yQ2Ebyh04trMwDmeZ
T+ZgkzJYc0ysRKEIOuKizBP333MlqoNhZSgTeEr8LGbMNCclFIkuzCfID2lMuhgcfDbMHQlQGsqi
izNnFbTqxMp+RQT99eIVzxbpVuiSrbvf1zs4lzZP6+P+8PJ7IQ2er7fvj5tHpTZf3j+/PB/zR+Nc
ITGYfGocHgBQezuLUxySVFgwYKznSNB5Y8efsVRMKQntS3om4gn14RAahza7eaYSBKecypWykGAo
bazQhCjhZlOi9dyGd4CzmIN2qbOjwxyZUCH5ytKwQkFj2KlS3F0Nuu3Bait+EvHX3WB400VLJIVV
dD4BA9UvuAWSeOqzSUfp5eZxs/tm7qtzG2Wn44laNsp8ivsk3iAFu+TAwz/CQyTdFFofCwrNkwBv
af1lswUvwMqjgFNYqUPR8BUWCYeDX0irDAu0En9HROL7+gB+2mZ3zA+H09Px2c7JlPLPWUjmxH4U
tQiJPyGdkaL1/ffNLm9uM/CisiBJK2sYR9T7e328//6w7y4bkAK+UIgMxEhivOrOR/WwP/xYH/an
3YOtD6H7kAT8i1e2W4O4pfglbsH4DHGWxu2NVuKRPhkLC6xE/HV9nz+3RCBmNM5iJAvj0TE5GuHa
tAYWDvIAdtfo4vbaRdaziUsKYR7dbSQsf9yWg4GOmm5BGw1gmzUqsdpfdKOV7rqxsE14D99RYjct
JRrcIe5SAb022qXt9FCgBLP7AjVJCt4ki18hmnO5fI1kqZRNdDSeS0S9/PG0VQecd9qtf643W+UZ
vfMeNs/aRdpBZPYz91BCPSD5ctpsYccfvfVz6TzZFJJL3yZSBc4CGvrgWSlDbpvwPOow6R82PwvH
o9nA51T5Stng+urqArklUNFpSzaGnT99nRYs0T+kFAsKJ4gkQnYYTw572LHPILbjy1PurXcP3tdc
hW55YzIQjdlUCALUZnSkIBB2ONQBkHO2QhPCnfg4jZDdLVJYkUaRIxRS6DGdtBhtjk3FwqHNgC3j
XhXlOmmI+HRxcWF3ji9vru2IkQtx1YOQAjtxUWTfS9G1q8MEDBtNI0pfQffjbRFNhRs1Ao6Zg4/Z
Jwf8xg7HPBXM7kVHJAgoJg7LEy0o7AwI3R2MlOhhL/bSESZNCPPJZDnowWahY4nwitOlU9BzivBl
ZufK0FHHVsRRssRTI9pVwCXy/SYkHGQYgcelnJlA3n2qcHwBp2OmeoAmcOZMGPjhU8NIVpkhcNvo
mIODAq5DiFbN3heJdhpExmZNBI3nYdJibtxMt2h7whLkdxqXU7seNcETxoDThOL2UJKEWSoIxyxp
8QfQLEk4y0ACeAYGpYmGfWdq8jQhpXtpkXnCCYnUOcviRlhUwecsTGOJ+Mq6niWVLUHTcoYU14ll
mgCkrAvW2S2bVJgFGGHStt8AUlMKkEQOb7gkSkZySnjkoJIM9GtsP/PozczZMydjxmRAl2liy/dE
FHOGYYvdPTbmIXgTgJOU+gDSp1iwOTz+DYGA7Zwmvn2bg26HGR+ndiT2x8jGXsymdFJmiGotKkAj
e5xXYq+b6EpL4LTMWBAIAmHVL3xR/DRSsgHECtA+I7Fy9lv5WpEgDtvaiSahChQAzyDAjUCsZqar
D1mNGqE4RY10JUQd8EnSSY22zrtmrUvUHKQ5KsgYDGzRzszVnrtTwbap5yIJKcT/EjbGTOmFuBsZ
NhfJaUaiFDqmzcOkIpCcN9KcAbVQQeiRNJx0QTBmOoddL/Rf2aDpPdSI4dVFl9ROewe0RpaULInt
QEimK0GVIQBpcKU7g0JzCq9v/3d+8B7Xu/W3/DHfHav0vPcG4YS+A086els7zUlDmZMIAuUJwg6r
FvVkNAQL5AKp+4tUgN/Q2HeaLzU68PDwc727h6gd64uV02GtmNO+acH4OdR864l2WlR10Uiew3Nx
X2JlSaOR3dfSuDGSknBbHr1Ap1KyuDPgnPqEuTudMjkjdgFqfODwoDWyvEJgdie6mBAI2I2l48iN
tJjtxnxDhGcqEZOtCOJmFlujO2tvIomxJ4uZsAXhLZhYCUlahzIolT6DO2JWdgbRuHk6F5qURIYi
FWoTnfX9rTemENjWylN3m3SDOzAZXnDI/3PKd/cv3vP9etvKugFBFnDyudNyfHqut1aCYWclOMIU
vfMIFfA3wvAHPpmbDTfUFx7By9HcWrebRkdR8dhD4lMOttxmJzQaxYabpEBqxCak6KEJqwZucUwS
xuXYoYK6nbA7wHochwqV95fKhzFy8wI1bDM8O/xuO1zgX8OmmS3sI4Y40FdLplbrI14fHmAp3xqX
MAbLmrTbA/Wm++PT9vTNpmblrZWacKcp+ZXfn446sfF1o/7sD4/ro5FVG9M4iKS6yzKusQoYYqms
/aASGMGBXHlCcX5U6cNCgSufhchzgvKMNm5sz1wDoWt1EjALRA1dC0ZDQEWQLXWQxs2UE3SdtUxi
tcQFe7XvmGRwWsMBj4Tdec6QP0cxJn7GQRoNAyNmCh/QcTZFYtrqVYElp7Z0abNRi5EkJJlUvpVo
daiHL2nAy7B7whXZnPAxE/ZYF4iS2H5+KbmpeKEHOeH2XhFP7J6vWMVgWdmMEvsOViuSIcd8FI4I
Oz+0YEj5RW78MuBg7tM4duTiNVEXb2J9ioxAs2iAkwpcRygAg4+Ts8JY+jvTjCluLu/cnlpQo13/
o0lc9xEAPqChtJxsPsZJyzN6YxZTvDV3LGiOpu9cI2D5X3Wi6TvXT7CU/7gTTWxVQ2m9KefUnxDT
nsxDFGc3F8OB69YUg8wsPYUhNruBR3t+hSb2lI0Kgx3R6vDKCg9RMnbuR1+lZO0pTAL/iR21gLkX
1qyzCp/3QrnGH/cH7+t6c/DATTnlLQdFDdy5ZDMNvnfMn4+WRslMTojdF52iiCOf2r1cyn37gTt2
FLIQQtTaDrrqnv/c3JuBe131s7kvwR5rVxdB0BP7KGTmPX7C9QUPWHIe6ShknNKwUSgRLDJVHOFI
TxcXc0VOvesj7ne7/F7dULz3TrvN1w14nadn4PgJwhTvf97/b1kKVjyDA/mjWRAB/2Jwr1i35yh/
3B9ePJnff9/tt/tvL6VIwKOMpN/YY/DcdUTWh/V2m2895YJ0q0ggaFXOWu0zlACV128c5hUUxBfY
19ygEam+Te4lmzgy3BV+MLwZdWej/CkdCG7XL1Z3LO7aqaIG5aGQmuFGlbUmQUMHKujSfjYCdxDa
2VU7VNmFz5lL80s0pkL00ajBfYRvr+33DBVJ2qow6hBgtoDfKLImNSqisKiL6Tbmq0Sy0F6BUhHF
Y9/UkQosljc9jTgygjsDCLymsbwbXNtwutTsemRkvs6FQqqYrbGA2OcsUoYL+3P7GoJFzxhs4ow0
nbIicJToI/wm9GMURB95GHb3DChAdwoFsFTSfP2cQ5dgtvb3JxVw6tPx4+Yh/3D8dVQevfc93z59
3Oy+7j04NpVKPShT1nC3ja4zATz1LvfUz1qK2e3Fp8LIq5eAwkHV6T3rrLB1ewAChPTKeEHIEp1/
tzUX2BEEqulK7aozLMPOAqlZ3n/fPAGgWpqPX07fvm5+mZtbdVLeV3RnhSMflMkFz0g81e6gVRxF
fF6PokJWMVXHCeWfuy1YEIwZ4lYZWm5zOjSq4vJ6OOjbUH+pzJ5DyCpgbsWYDTkjbjciCqeuwASR
9higOYarDx2vp9J+ENSaa3FPQTcKg20z8hxRH3ax5LYMvGprpGHhSWfMskBU+1P3XnZbXHu/edg8
/3jnHddP+TsP++/BgrztHhSiaWemvIDaPZoKzYQ1TD33yW0rJzjEg7HPbLdO53EnVm5w16SJ/WNu
ihQ8h/zDtw8wUe//Tj/yL/tf58yG93jaHjdP29wL09j0p5QYC0MBiJZ44bPyt5oFbhoTssmExt3C
Nc2MPKx3z3pQdDweNl9Ox1bNgepBqGxme6WbJAF+jYLqv68QCSS6JDW32/3f74tS9ofuHVIxgMT2
sLZa1ctFtoQfrb5uPoDqFqjcBKoEIUDCoXfFVNs5qRZ6igZXw54hNMHIHicVBAj3zwJR/Kl3FiVB
xhxlo2ei275efFV8OrTbl6IHFdqLVZ9yxENnTQeZIG1rYrJwhUFnmp5LkTONsN4ZluonUWtfKRAs
BW6bMw0X80ULrKAJbabVavpo3jdyFs87zRIfNlbLuHfafRYQs9j4A5sbUUGsrC9HVjAN7awDYjjq
5UJQYesxDa2im1OrpOdUEmHnuCgoAG96TGPTL9AU41SAnWumhzQCBCDVjaWYJgx66NHiaHk5uB30
bARf4svhjV1LNQFx+YeFiUxlCh6Kr8q+7WqsySa+I0tZYMvyjxjzq8s+XlqEWRQ5QsFi/yW9m5PK
3sYxRQPH7i2UOOkRC43s3o9Gau7x6OK6pwOxioDmBsxYj62kiT2fUPCHxMCeSCzQgg5HF3b/TRN8
1qqXBahHiCXNoFeBPocITlI3Pkz6sIUgRn1T8fHl7dWvfvxFzyaRwL8bmw5G2eUo6CEIJUdCOm5N
ixUXyWXPOnauPrQHwLYPpcdYOQbeG0WgmrzTpOAHN7I0WL2OYouAinSPcsDeN31f740+bFXeI5xH
zZRP13kOTupdQ0/VFrld6CAV1FE7V6CU59WHdmhD1Rh13SiV4/MGl7cj702wOeQL+LXeqCk6Tdbp
AA5694xabkAju9lpVbbRF1pzis3XqPw0ilaNvAaL/ZYTW6dsP6copH85MoYyjTssIY53ELnW2ag6
LcHbGewimzBd9cwasCHtvj1Gjt9VuhE0Z3ChaqLBRkZfNse3jamr/AfhxfVapU6U1qnAKYLoPSIo
rEEijSckMqWDwRMFK2w5ntUIRRSTXcLRWQ9CwoHZAwntm46ESei4Q4Yeri0jkvCyZvUSXw2u6sc5
46p83xhXrpIps2bHQhX+102NiYioccwv/JuLX5dWFrW9sRuTCN8Obm0OjTEQBxe+4Q7F9OpiYLff
gBraeqPXV9W1rzxtN0/e1/XjZvvi7Vy7opH6l+A9OWpm5OCT48xV+RCbwzhNQANN4eubQGEj1dcO
ps+bqG1xOazXA0X+zWAwUOprdlmCSRajxKaPyEeJJFgXRAWUNy6X2rhOHzUlOGLWwiyUgM/DzNv3
0cgcQr9+6ROHh4XFze0vW7f+hIu6T0LAry5EWUEaTwHs1nhpqC6SgkTU1OXhTIv3DLkBW4uT5rNk
zGS9BEF0YXfFKjzYO5LJBRXSWi9bkd0Mhremaiu4igMzDrExEdZbPPDwbxvTTihuzBwsk19u23qn
lbCOB1pZANjohoWgKONT9eqneetYAV19aHVluvjBrE6S9q3jk2vnzrkedgtRTDsODVs2HGES08Y9
TQEpIg9JJ3AS23aCHw5nTQ1q7E0NcO+AAl2+W1aVeegaS5t4xM3lzfDCPFQihKeG/q1IGLJFQI2V
4DeD61uTIw1wcwTKMbh1+Lazif22RsxWNqMpZrc3oealoQJzEjJMpa0+RYv5suEwxMvhKytZL6WR
wSOhUO89298roMuJ/VJZDGnX8ZH7H/nO46qOx+JpyO4to/LGtvnzs6de3gEHdvf++/rxsH7Y7N+2
D4bOrW/RwXpXvGVZvQJYH5KOYsbA9+3LOaWJY6ET15GUJHa4cDVQE3EFNOD3OBw6aAWfBAvtOgVo
9V0BzgEVUtcscvhguUSmwo/VG9vnF7aNBKPfdSUlrNjT9/3uxVZhBr5N3H1Jle6eTkenO0zjJD2X
gqXP+WGrQo6N5cVOTZlFLBVEvVD9YodD+IrSpRMrMCckzpZ3g4vhqJ9mdffp2ngZryD6N1sBiX23
aAIp+vFk/hreFvEVMuzUJTRazsiquvYp4RUEjobZuHGRcMbAcTVzfC/CmSacvUqylK+SxGQhrZ6v
IX0jKGD6pRkxbLzjpYGCcOoo7y8IoEPmKHcpCFRuwlGPXI6LB4OLxPmVFYpkLpbLJXLcQlWqIiTF
9jqeUllYiqeFuvVQqVrKjkZM14cH/XoJ/ch0nYV5c6IKIczXAuAxozcXo2EbCH91KYaZRtQILG+G
+JPD+S9IEsRdi14SYAoLaDvwNBpiyNb6FnCOFtZOJygi7YUtrM/39WF9DwajW28xN+LMucxKQ1rD
pgsD1uADheqFpKKmx1JrK/LDZm29lykb3wyvuq5VDGecRjwXzVv1Me0+/i1sZWqqjPX2Jkvkysgg
FDcBTmBZ6TC8Opc66K+sIbxRppZUwnCcdy7LpWpNLSdLEtFmSV9EwRWLfdsxtCi/ocBTdc+to7z7
TRT1sb0AdYHg1SaneP7/jV3dc9pIDH+/v4LpS+8eOikJSeBm8rD+Ahcbu16bpH3xUEKppylkgMxN
/vuTdm3stSXgIe3YkvdTu6uVfhKI+6gVvNS4Rjspg7BLbkZ3A5IiYtAF7Iix30azb3HXtOZp/y4o
Yr2fL9vX13fl8K1OQy0+ho2sjXCoax8z6j3jTg8fxZwuyZa3tze3+Zi7WsECJCBn9ZjHDGAQ5nas
Ihy70Ytad4hDUjO04S+mO5G6gY0hVIRdzqYNct2dEo2K1BrjFPvYz0PRvk5qXODi5WWx/7jv9T/9
B7pr78ebKaldJOFxlw63m+Kw3aFy3FGBJo+hGc6jXmA8D7O5whpNZO7d94efbxnzc8kzcQTj6tB1
aHwhoi66RuFiv6SmC07OXMhuxIoyIv9ZPRcL6isVnJS3NhCDNh8E15Ue6BTr4gD747x4Xm171m67
eF4uFFi0AiI2y3bmXWPkeLd4/VUs96Qd2mIbocMPH45J5Tb77csKcz68IvZPL9fuBM7HgjpG4LWN
dunIQyQs6t+WYNSB0BHU3lt1EM3DjRpKhEUrGYvElCmdgcik1W0wvNSxmBMBMmI3VEaDEhl+YIPk
TsyYIaymc9pFqfsvNiBHH4iAS/FqgyEm+9JRgYr+R40RKfa/q1Z+rPC2WOR48byG+ytx18Bix8IZ
E9brMLSvpKNOEmr6gdz5JHAdSmpBZ4VD1On6FRS/CQ/GV+muWK8b7/zNz2JTWNhRarOCf2e+JYhZ
cx1h9z71VrvdFrWaw2p5DEfcrbAcXAp/J0L+cwL+rgppl4xpujCJ06pnI0TVgDildm4HrZR3+hTD
mCB9QzTSKabXGuJUV6lf5U+IaqEtORUHc0kG+g3QiVWQuD7oRfCpWeXxtTp66AOtYlGgLBh25tyr
KzjRgS+KgbYuyDJVo7CZKHb+28j25DXd8RCk5En3umppFOpx+FNfoqLU9wzc49csSiljt9NlRbwc
3zRNHbC9xuuQ1xUa7aG8QkQsyk9HfHwZje7uPhsd+xIFftM39B2YmnT93JKAzPGo+p1IXnkivZql
dP1AM+oOJXxhvJm3WfD5mEovclyMlH8Y3NxTdD+yJxgdnj58KPbb4fB29Kl/THo5S6v5q/cafMXH
MSty8tjpZbxfvT1vVdRep4c1BrFW4vHVFNNRUveyb7LZ2zSMzY8nGWy3gcXIQUlV6QOo5YvpPw34
oPqvI3ZH5WMFytZmtX3btzpXy6VzQmY9njY5SUIHIEe2XP5Tiyed+MpWw0KS5id2i0nM077OngY8
FdPLcrSMnozKo61OAdkWsllrJ8Ln+Y3hRlRv2E1RkekbF5J0DDDtB/GkY1TsdGt2zlTtnKjbacMr
q4sy3EgaFatHKKbhbX5CQ0V7VHRkRMMEk80SM+QFHqVr52Mp82li0ZFeDR4ZT0MynW9oGVOCz7NA
VltTowUlIXFD0NUePixfYTP70JBOn5GUmR2zEh2BLsuuSlYuR+0C/yojiQ6FUn3S99emYScWSYow
rdkxkNIM1I+SWc1DH7jSO8MhQn8szvGkIvHP8ITCpjmMg+fIYYCzQQYxYCIQFhO0qZUDmVmn2wA3
B2io1KkNTnKieUmFqp2uN3DCMwXJ8bmBQbwCNP5MMdm5mZyKJDw3T67HNEbvcDqZX7DYrN8W61U3
wwcsknrVNJdS82yvV0cgj+pBDiuKXkJNpvuLmO7pHcFgGt4ygA2TiYa/tJguqu6Chg+ZuLIWE+2E
bDFd0vA7Gh7TYmK2fZPpkiG4oxGILabReabRzQUljS6Z4BEDKjSZBhe0aXjPjxMo4yj7OY2RNIrp
X1/SbODihUBI2ycxX42W9I3Tv0Hgh6Pi4GWm4jg/ELy0VBz8BFcc/HqqOPhZOw7D+c70z/emz3dn
GvnDnPFXV+SMmass9YYPxwS++8OujlYkncpJ5PkBB4acAtlyu4rDVP8Ixq/F8ncrxFzn6lcmauos
FghbBiVZBdbVphqVDZhNE6OoKnl8mfIsn4sgc+u01drOOkXkYyOfWRDhTwV4ZVLE/qDmVqmU0XCI
umVmhMuqmHqV25scEF0T/kLACbJKK8xk2igLiP1Z2/DOsJzIdFV2O7K+0ImANB3+ykwkhoNG0Vhj
jSYzyqQmzmmfggdXLjdX4RGMhyObPfozp1N39b0C1QEVhBLE0rBF2VmeguaPgQ/t1LeVIiKS4Fv9
gxHtMU2FPcU4YS+IaC9ogy/PJH3V1lQ0NmuZtCNQX67bZeCOKwKYwRP1JKDMM0Eeg6mqhjJYoZLp
4QjKMC6v+WZyrTBWifMaAOgog1VT3U5KD+tS/5gLkRRo6nLRVWUm/64xavf+etiutVeAKlJHn3e+
OzpwlqqAhpFYG32LH7vF7r23274dis2qVaKd27afMrGaiU3iieG9wp3WirZvqXdUwr3vQEQxxczt
9WAef01HJHB5/iq7FEworzZOc1owAVeZC7MBIsGdUufNx6Cr/wFVmrdQmmgAAA==
------=_Part_153987_26794380.1162217706568--


