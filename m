Date: Sun, 2 May 2004 19:17:45 +0300 (EEST)
From: "Rus V. Brushkoff" <rus@domain.hid>
Message-ID: <Pine.LNX.4.53.0405021911080.23891@domain.hid>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="655616-2026017981-1083514665=:23891"
Subject: [Adeos-main] 2.6.5 + vesuvio + gcc-3.4.0 = success
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: adeos-main@gna.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@domain.hid for more info.

--655616-2026017981-1083514665=:23891
Content-Type: TEXT/PLAIN; charset=US-ASCII


	Hi.

 This little patch against hal5c2-2.6.5.patch needed to compile all the above.
The rtai_up examples works ok, but lxrt scheduler failed (box freezed
solid while starting XFree 4.4.0 and running lxrt latency test).
Congratulations - it worked ! ;)


		Rus
--655616-2026017981-1083514665=:23891
Content-Type: APPLICATION/octet-stream; name="gcc-3.4.0.diff.bz2"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0405021917450.23891@domain.hid>
Content-Description: 
Content-Disposition: attachment; filename="gcc-3.4.0.diff.bz2"

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

--655616-2026017981-1083514665=:23891--

