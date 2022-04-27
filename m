MIME-Version: 1.0
From: Kevin Hall <hallsoftware@gmail.com>
Date: Wed, 27 Apr 2022 10:10:44 -0700
Message-ID: <CAG8a9PyaFXitcmim4801QgY4azT-RWBv8XOHen-_PvzrUQrqyQ@mail.gmail.com>
Subject: Xenomai 4 / EVL: Out-of-band access to EtherNet interface
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,


Is OOB I/O service a candidate for an EtherNet-based fieldbus protocol? I
read in a comment that it only applies to VLAN-tagged IP protocols, but I
don't know how old that is or if things have changed. I am able to send and
receive packets when using send() and recv(), but since these are not
out-of-band, I am often times seeing large delays in the processing of
data. That's why I am trying to use oob_read(...) and oob_write(...).


Additional Information: I am using Xenomai 5.15 with a Raspberry Pi 4. The
fieldbus protocol is EtherCAT (0x88a4).


I would greatly appreciate any suggestions or help.


Thank you!


Kevin Hall
