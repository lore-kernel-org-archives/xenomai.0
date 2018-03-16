From: =?UTF-8?Q?St=c3=a9phane_Ancelot?= <sancelot@numalliance.com>
Message-ID: <48e48b6a-c767-1ae0-29cf-e59dd9c9c0d4@numalliance.com>
Date: Fri, 16 Mar 2018 12:19:32 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Subject: [Xenomai] shared session and latest release
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,

I upgraded my applications to latest release (next branch) .

I do not manage to run the shared session , using session-label to run 
the program as user (fixed in a tunable config)

my session name is numalliance/automat (automat corresponds to my group 
user id 1000)

however , if I launch the program as root , it works.

I checked /dev/rtdm files, they all have rw access for user/ group / other

What else to check for ?

Regards,

S.Ancelot



