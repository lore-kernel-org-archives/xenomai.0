Date: Tue, 9 Jun 2020 22:07:53 +0800 (CST)
From: =?UTF-8?B?Y2FydmVy?= <carver@tom.com>
Message-ID: <933592194.774.1591711673676@debian>
Subject: =?UTF-8?B?W0NvbnN1bHRdIGxvY2tpbmcvc3BpbmxvY2svOndoeSAqbmtsb2NrKiB1c2VkIGluIG1hbnkgcGxhY2VzPw==?=
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

hello,Liuhailonghavesomedoubtsonxenomaimaster.Weuseipipe-core-4.19.82-cip14=
-x86_64+xenomai-3.1onmymachinewith16processors;everythingisfineuntilwerunth=
e*latency-t0*testcaseoncpu1-cpu15forourschedulebenchmark.Whatwefoundthatthe=
resultsofthetestcasebecameverypoor,worsethantestingononeprocessor.Thenwecon=
fig*IPIPE_TRACE=3Dy*and*XENO_OPT_DEBUG_LOCKING=3Dy*,andrunthesametestcases,=
wefoundthedelaysofthetestcasecausedbytheGlobal*nklock*.Wearewonderingwhythe=
samelock*nklock*isusedinmanyplacesinthexenomaisourcecode.Isthisnecessary?Or=
doyouhaveoptimizationsforthissituationinthefuture?Thanks.=E9=9A=8F=E5=BF=83=
=E9=82=AE-=E5=9C=A8=E5=BE=AE=E4=BF=A1=E9=87=8C=E6=94=B6=E5=8F=91=E9=82=AE=
=E4=BB=B6=EF=BC=8C=E5=8F=8A=E6=97=B6=E7=9C=81=E7=94=B5=E5=8F=88=E5=AE=89=E5=
=BF=83
