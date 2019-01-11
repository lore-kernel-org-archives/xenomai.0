From: Johannes Holtz <johannes.holtz@compador.de>
Subject: How to close orphan FDs
Message-ID: <1c7af21b-d6db-fdd6-6083-bad2b877cf1d@compador.de>
Date: Fri, 11 Jan 2019 15:55:52 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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

I managed to leave some labeled XDDP and IDDP FDs  open after a segfault.
Even though the process is killed the resources/FDs are not freed. Is 
there a
way to close them or do I have to restart the box?

Cheers,
Johannes


