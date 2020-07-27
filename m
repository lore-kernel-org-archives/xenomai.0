From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Subject: rt_pipe_write memory allocation bug - xenomai 3.x
Message-ID: <5adc97a4-014f-3a50-9109-4e574662cf7b@numalliance.com>
Date: Mon, 27 Jul 2020 14:44:01 +0200
MIME-Version: 1.0
Content-Language: fr
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>, Bastien COUNILH <bcounilh@numalliance.com>

Hi,

Using pipe created with poolsize = 0, meaning all message allocations 
for this pipe are performed on the Cobalt core heap.

Unfortunately,  using rt_pipe_write(), when no user task is consuming 
it, we discovered after almost many rt_pipe_write() cycles (700000 at 
least in our process)  , that the cobalt heap and system heap seem being 
corrupted.

Leading to system issues like unattended task crashes .....


Are there any way to bypass this problem, like knowing if pipe has been 
opened before writing it ?


Regards,

S.Ancelot



