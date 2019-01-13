Subject: Re: How to close orphan FDs
References: <1c7af21b-d6db-fdd6-6083-bad2b877cf1d@compador.de>
From: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <3ed8dc64-20ce-1c3c-05fd-5fe6ab7dee55@web.de>
Date: Sun, 13 Jan 2019 11:27:30 +0800
MIME-Version: 1.0
In-Reply-To: <1c7af21b-d6db-fdd6-6083-bad2b877cf1d@compador.de>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Johannes Holtz <johannes.holtz@compador.de>, xenomai@xenomai.org

On 11.01.19 22:55, Johannes Holtz via Xenomai wrote:
> Hi,
> 
> I managed to leave some labeled XDDP and IDDP FDs  open after a segfault.
> Even though the process is killed the resources/FDs are not freed. Is there a
> way to close them or do I have to restart the box?

Could you describe in more details - or even with a small test program - how you 
created the resources that then leaked?

Conceptually, everything should be cleaned up automatically when the last owner 
of a resource vanished.

Jan

