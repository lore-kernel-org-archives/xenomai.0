MIME-Version: 1.0
Date: Mon, 20 Apr 2015 15:51:57 +0100
Message-ID: <CAL92PvWNqZ4SF=WToXa_vhYkpn0R5pOdqZGwtsPNgjyx84vmJQ@mail.gmail.com>
From: cristian ramos <cristian0084@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rt_sem_p(&semCC_, TM_INFINITE);
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone,

   I get error -3 when I use int status = rt_sem_p(&semCC_, TM_INFINITE). I
have seen in the documentation that the possible values are: -EINVAL(-22),
-EIDRM(43), -EWOULDBLOCK(11), -EINTR(4), -ETIMEDOUT(110), -EPERM(-1),
somebody know what is meaning -3 values?

Thank you very much for your time and would appreciate any help.

Regards
