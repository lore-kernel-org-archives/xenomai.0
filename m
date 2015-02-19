MIME-Version: 1.0
Date: Thu, 19 Feb 2015 15:40:35 +0200
Message-ID: <CANWkrRN54ohRTAuyfySuc_hqZWB=cA277imt8uAQhfR5bVr5ig@mail.gmail.com>
From: Michael Smith <2michael.smith@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Xenomai] Compiling issue Xenomai 3.0 rc3
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi. I'm having trouble compiling the newest release (Xenomai 3.0-rc3).
With the error

autotune.c: In function =E2=80=98main=E2=80=99:
autotune.c:298:16: error: ignoring return value of =E2=80=98daemon=E2=80=99=
, declared with
attribute warn_unused_result [-Werror=3Dunused-result]
          daemon(0, 0);

Is there an way to override the -Werror flags so it doesn't break on
warnings without editing the make files?
Or is the policy on Xenomai to always compile cleanly without warnings.
Is this maybe my compilation method, but then again I did compile Xenomai
3.0-rc2 without an issue.
But I assume when a release is done it does compile cleanly.

Thanks
Michael
