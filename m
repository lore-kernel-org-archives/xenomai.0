MIME-Version: 1.0
From: Antoine Hoarau <antoine@flr.io>
Date: Thu, 30 Jan 2020 22:40:22 +0100
Message-ID: <CAPnNZ0U1xhs91myD8gtD3CC_MdN-LW+9UX-r1V+XVwNGg8RMfQ@mail.gmail.com>
Subject: RTnet from userspace
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

Hi,
I'm trying to run rtnet executables (ex: rtifconfig) from user-space.
User is in the xenomai group and can run xenomai applications without
sudo/being root.
rtifconfig results in:  ioctl: Operation not permitted
What would be the best/most linux way to only authorize the xenomai group
to access those functions ?
Thanks !
