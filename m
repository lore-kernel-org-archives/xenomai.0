MIME-Version: 1.0
Sender: had2006@gmail.com
Date: Mon, 30 Mar 2015 15:55:59 +0100
Message-ID: <CAKk99t15m2dbUzGNxi4TsAVk4suZGc14qxv2cBh+iG1nWcM-kQ@mail.gmail.com>
From: Helder Daniel <hdaniel@ualg.pt>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] There is XDDP Sockets support in kernel?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

When trying to compile a kernel module that sets up a XDDP socket (code
snippet below) with Xenomai 3.x-rc3 on Cobalt setup,
rtdm_bind() returns ENOSYS.
This means that XDDP sockets can not be used in kernel?

================================================
s = rtdm_socket(AF_RTIPC, SOCK_DGRAM, IPCPROTO_XDDP);
memset(&saddr, 0, sizeof(saddr));
saddr.sipc_family = AF_RTIPC;
saddr.sipc_port = XDDP_PORT;
ret = rtdm_bind(s, (struct sockaddr *)&saddr, sizeof(saddr));
if (ret) rtdm_printk("senderK: bind error: %d\n", ret);

================================================
