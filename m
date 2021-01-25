MIME-Version: 1.0
From: Sam Daniel <daniel.jacob.samuel@gmail.com>
Date: Mon, 25 Jan 2021 12:20:02 -0800
Message-ID: <CAPMj8MtS-vAssX+P8rywMUoFfs-DeCh_2f4sZts5Jk2Dk_rOEw@mail.gmail.com>
Subject: Look up all IDDP/XDDP labels in the registry from userspace
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

Is it possible to look up from userspace code all of the IDDP/XDDP labels
that exist in the registry without leaving the primary domain?

I have tried a few different ways of reading the contents of
/proc/xenomai/registry/rtipc/iddp. The inotify API causes mode switches (it
relies on select or poll), not to mention that inotify does not work well
with virtual filesystems. And using the C++ filesystem library to read the
contents of the directory also causes mode switches (filesystem
interactions).

Is there a real-time API function that I can use to query these labels?
