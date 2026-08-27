' 3D CUBE & DONUT DEMO + MODE 4: SUB-PLANCK KOSMOS z(-1)=-1/12
' OPTIMIZED VERSION - ORIGINAL ARCHITECTURE WITH Z-BUFFER & STABILITY
DefInt A-Z
Screen 12
Window (-320, -240)-(320, 240)

Dim phi As Double
phi = (1 + Sqr(5)) / 2

Dim cosA As Double, sinA As Double, cosB As Double, sinB As Double
Dim asciiChars As String
Dim zx As Double, zy As Double, cx As Double, cy As Double, xtemp As Double
Dim projected(7, 1) As Single
Dim buffer(1 To 640, 1 To 480) As Integer

mode = 1
previousMode = 0

' ========== CUBE DATA ==========
Dim cube(7, 2)
Data -50,-50,-50,50,-50,-50,50,50,-50,-50,50,-50
Data -50,-50,50,50,-50,50,50,50,50,-50,50,50
For i = 0 To 7
    Read cube(i, 0)
    Read cube(i, 1)
    Read cube(i, 2)
Next i

Dim edges(11, 1)
Data 0,1,1,2,2,3,3,0
Data 4,5,5,6,6,7,7,4
Data 0,4,1,5,2,6,3,7
For i = 0 To 11
    Read edges(i, 0)
    Read edges(i, 1)
Next i

cubeAngle# = 0
donutAngle1# = 0
donutAngle2# = 0
Dim Shared asciiA As Single, asciiB As Single

' ========== MODE 4: SUB-PLANCK ==========
Const ZETA_M1 = -1 / 12#
Const ALPHA_V = 0.8
Const BETA_V = 8.0
Const K_CRIT = 0.85

Dim spInfo(1 To 640, 1 To 480) As Double
Dim spCoher(1 To 640, 1 To 480) As Double
Dim spTDir(1 To 640, 1 To 480) As Double
Dim spKrit(1 To 640, 1 To 480) As Double
Dim spEmerg(1 To 640, 1 To 480) As Double
Dim physT As Double

' ========== Z-BUFFER VOOR MODE 2 EN 3 ==========
Dim zBuffer(1 To 640, 1 To 480) As Single

' ========== MAIN LOOP ==========
Do
    ' CLEAR BUFFER - ORIGINELE METHODE
    For y = 1 To 480
        For x = 1 To 640
            buffer(x, y) = 0
        Next x
    Next y

    ' CLEAR Z-BUFFER VOOR MODE 2 EN 3
    If mode = 2 Or mode = 3 Then
        For y = 1 To 480
            For x = 1 To 640
                zBuffer(x, y) = -1000000!
            Next x
        Next y
    End If

    k$ = InKey$
    If k$ = "1" Then mode = 1
    If k$ = "2" Then mode = 2
    If k$ = "3" Then mode = 3
    If k$ = "4" Then mode = 4

    If mode <> previousMode Then
        Cls
        previousMode = mode
        If mode = 3 Then asciiA = 0: asciiB = 0
        If mode = 4 Then physT = 0
    End If

    If mode = 1 Then
        ' ORIGINELE CUBE CODE - WERKT PERFECT
        pulse# = (Sin(cubeAngle# * 4) + 1) / 2
        morph# = Sin(cubeAngle# * 0.8)

        cubeAngle# = cubeAngle# + (0.04 - (phi - pulse# / 2))
        cosA# = Cos(cubeAngle#) / Sin((phi - (Cos(pulse#) + phi)))
        sinA# = Sin(cubeAngle#) - (Cos((pulse# / (pulse# - phi))))
        cosB# = Cos(cubeAngle# - (0.7 - Sin(phi) - (morph# * (pulse# / phi))))
        sinB# = Sin(cubeAngle# / (0.7 + Cos(pulse#) - (morph# / (pulse# * phi))))

        For v = 0 To 7
            x = cube(v, 0): y = cube(v, 1): z = cube(v, 2)
            dist# = Sqr(x * x + y * y + z * z) + .0001
            factor# = 50 / dist#
            sx# = x * factor#: sy# = y * factor#: sz# = z * factor#
            t# = (morph# + 1) / 2
            finalX# = x * (1 - t#) + sx# * t#
            finalY# = y * (1 - t#) + sy# * t#
            finalZ# = z * (1 - t#) + sz# * t#
            If morph# > 1 Then
                bloom# = morph# * pulse# * 1.8
                finalX# = finalX# * (1 + bloom#)
                finalY# = finalY# * (1 + bloom#)
                finalZ# = finalZ# * (1 + bloom#)
            End If
            xr# = finalX# * cosA# - finalZ# * sinA#
            zr# = finalX# * sinA# + finalZ# * cosA#
            yr# = finalY# * cosB# - zr# * sinB#
            zfinal# = finalY# * sinB# + zr# * cosB#
            If zfinal# + 500 > 0 Then
                projX = xr# * 500 / (zfinal# + 500) + 320
                projY = yr# * 500 / (zfinal# + 500) + 240
                projected(v, 0) = projX
                projected(v, 1) = projY
            End If
        Next v

        For i = 0 To 11
            v1 = edges(i, 0): v2 = edges(i, 1)
            projX1 = projected(v1, 0): projY1 = projected(v1, 1)
            projX2 = projected(v2, 0): projY2 = projected(v2, 1)
            colr = 9 + Int((morph# + 1) * 3.5)
            If colr < 9 Then colr = 9
            If colr > 15 Then colr = 15
            GoSub DrawLineToBuffer
        Next i

    ElseIf mode = 2 Then
        ' 3D DONUT MET Z-BUFFER - STABIELE VERSIE
        R1 = 100: R2 = 40
        cosA1# = Cos(donutAngle1#) * Sin((phi) - (Sin(donutAngle2#)) + phi)
        sinA1# = Sin(donutAngle1#) / Cos((phi) + (Cos(donutAngle2#)) - phi)
        cosA2# = Cos(donutAngle2#) * Sin((phi) - (Sin(donutAngle1#)) + phi)
        sinA2# = Sin(donutAngle2#) / Cos((phi) + (Cos(donutAngle1#)) - phi)

        theta# = 0
        Do While theta# < 6.28318
            cost# = Cos(theta#): sint# = Sin(theta#)
            phi# = 0
            Do While phi# < 6.28318
                cosph# = Cos(phi#): sinph# = Sin(phi#)

                ' 3D COORDINATEN
                x# = (R1 + R2 * cost#) * cosph#
                y# = R2 * sint#
                z# = (R1 + R2 * cost#) * sinph#

                ' ROTATIE
                x2# = x# * cosA1# - z# * sinA1#
                z2# = x# * sinA1# + z# * cosA1#
                y2# = y# * cosA2# - z2# * sinA2#
                z3# = y# * sinA2# + z2# * cosA2#

                ' PROJECTIE
                distance = 300
                projX = (x2# * distance) / (z3# + distance) + 320
                projY = (y2# * distance) / (z3# + distance) + 240

                ' Z-BUFFER CHECK
                If projX >= 1 And projX <= 640 And projY >= 1 And projY <= 480 Then
                    px = Int(projX): py = Int(projY)
                    If z3# > zBuffer(px, py) Then
                        zBuffer(px, py) = z3#

                        ' NORMALE VOOR VERLICHTING
                        nx# = cost# * cosph#: ny# = sint#: nz# = cost# * sinph#
                        nx2# = nx# * cosA1# - nz# * sinA1#
                        nz2# = nx# * sinA1# + nz# * cosA1#
                        ny2# = ny# * cosA2# - nz2# * sinA2#
                        nz3# = ny# * sinA2# + nz2# * cosA2#
                        brightness# = nz3# * -1

                        If brightness# > 0 Then
                            colr = 1 + Int(brightness# * 14)
                            If colr > 15 Then colr = 15
                            buffer(px, py) = colr
                        End If
                    End If
                End If
                phi# = phi# + 0.15
            Loop
            theta# = theta# + 0.1
        Loop
        donutAngle1# = donutAngle1# + 0.02
        donutAngle2# = donutAngle2# + 0.015

    ElseIf mode = 3 Then
        ' ASCII DONUT MET Z-BUFFER - STABIELE VERSIE
        asciiChars$ = " .,:;+*#%@"
        R1 = 90: R2 = 40

        ' ROTATIE PARAMETERS
        cosA1# = Cos(donutAngle1#)
        sinA1# = Sin(donutAngle1#)
        cosA2# = Cos(donutAngle2#)
        sinA2# = Sin(donutAngle2#)


        theta# = 0
        Do While theta# < 6.28318
            cost# = Cos(theta#): sint# = Sin(theta#)
            phi# = 0
            Do While phi# < 6.28318
                cosph# = Cos(phi#): sinph# = Sin(phi#)

                ' 3D COORDINATEN
                x# = (R1 + R2 * cost#) * cosph#
                y# = R2 * sint#
                z# = (R1 + R2 * cost#) * sinph#

                ' ROTATIE
                x2# = x# * cosA1# - z# * sinA1#
                z2# = x# * sinA1# + z# * cosA1#
                y2# = y# * cosA2# - z2# * sinA2#
                z3# = y# * sinA2# + z2# * cosA2#

                ' PROJECTIE
                If z3# > -299 Then
                    projX = x2# * 300 / (z3# + 300) + 320
                    projY = y2# * 300 / (z3# + 300) + 240

                    If projX >= 1 And projX <= 640 And projY >= 1 And projY <= 480 Then
                        px = Int(projX): py = Int(projY)

                        ' Z-BUFFER CHECK
                        If z3# > zBuffer(px, py) Then
                            zBuffer(px, py) = z3#

                            ' MANDELBROT TEXTURE
                            cx = x# / 200: cy = y# / 200
                            zx = 0: zy = 0: iter = 0
                            Do While (zx * zx + zy * zy < 4) And (iter < 40)
                                xtemp = zx * zx - zy * zy + cx
                                zy = 2 * zx * zy + cy
                                zx = xtemp
                                iter = iter + 1
                            Loop

                            ' KLEUR BEPALEN
                            charPos = (iter + Int(theta# * 3) + Int(phi# * 2)) Mod 10
                            colr = 5 + (Int(theta# * 2) + Int(phi# * 1.5)) Mod 10
                            If colr < 5 Then colr = 5
                            If colr > 13 Then colr = 13

                            buffer(px, py) = colr
                        End If
                    End If
                End If
                phi# = phi# + 0.18
            Loop
            theta# = theta# + 0.12

            speedFactor# = (60 - iter) / 60 ' 0 = diep in set ? bijna stil
            chaosFactor# = iter / 60 ' 1 = buiten set ? maximale chaos

            donutAngle1# = donutAngle1# + (0.01 * chaosFactor# * 3) / phi
            donutAngle2# = donutAngle2# + (0.008 * Sin(iter) * chaosFactor# * 2) / phi
        Loop

    ElseIf mode = 4 Then
        ' SUB-PLANCK MODE - ORIGINELE WERKENDE VERSIE
        physT = physT + 0.065

        ' VERBETERDE FORMULES VOOR MEER VARIATIE
        For py = 1 To 480
            For px = 1 To 640
                ' Complexere golfpatronen
                n1# = px / 60 + physT / 3
                n2# = py / 60 + physT / 4
                n3# = (px + py) / 80 + physT / 5

                spInfo(px, py) = 0.7 + 0.3 * Sin(n1#) * Cos(n2#) + 0.2 * Sin(n1# * 2.3) * Cos(n2# * 1.7) + 0.15 * Sin(n3# * 3.1)
                spCoher(px, py) = 0.6 + 0.4 * Sin(physT / 3 + (px * 0.7 + py * 0.3) / 90)
                spTDir(px, py) = 0.5 + 0.5 * (Sin(physT / 8 + px / 50) ^ 2)
            Next px
        Next py

        maxEmerg# = -1E30
        minEmerg# = 1E30

        For py = 1 To 480 Step 2
            For px = 1 To 640 Step 2
                spKrit(px, py) = spInfo(px, py) * spCoher(px, py) * spTDir(px, py)
                If spKrit(px, py) >= K_CRIT Then
                    ' Aangepaste formule voor betere spreiding
                    spEmerg(px, py) = ALPHA_V * spInfo(px, py) * spCoher(px, py) * spTDir(px, py) * Exp(BETA_V * (spKrit(px, py) - K_CRIT)) * ZETA_M1
                Else
                    spEmerg(px, py) = 0
                End If
                If spEmerg(px, py) > maxEmerg# Then maxEmerg# = spEmerg(px, py)
                If spEmerg(px, py) < minEmerg# Then minEmerg# = spEmerg(px, py)
            Next px
        Next py

        ' VERBETERDE KLEURMAPPING
        For py = 1 To 480 Step 2
            For px = 1 To 640 Step 2
                emergVal# = spEmerg(px, py)

                ' Dynamische kleurdrempels gebaseerd op min/max waarden
                If maxEmerg# > minEmerg# Then
                    normalized# = (emergVal# - minEmerg#) / (maxEmerg# - minEmerg#)
                Else
                    normalized# = 0
                End If

                ' Kleurtoewijzing met betere spreiding
                If normalized# < 0.1 Then
                    colr = 1 ' Donkerblauw
                ElseIf normalized# < 0.25 Then
                    colr = 9 ' Donkerblauw
                ElseIf normalized# < 0.4 Then
                    colr = 3 ' Cyaan
                ElseIf normalized# < 0.6 Then
                    colr = 11 ' Lichtblauw
                ElseIf normalized# < 0.75 Then
                    colr = 15 ' Wit
                ElseIf normalized# < 0.9 Then
                    colr = 14 ' Geel
                Else
                    colr = 4 ' Rood
                End If

                ' Teken 2x2 pixel blok
                buffer(px, py) = colr
                If px < 640 Then buffer(px + 1, py) = colr
                If py < 480 Then buffer(px, py + 1) = colr
                If px < 640 And py < 480 Then buffer(px + 1, py + 1) = colr
            Next px
        Next py

        ' INFO DISPLAY
        Locate 1, 8: Color 14
        Print "MODE 4: SUB-PLANCK KOSMOS - QUANTUM EMERGENTIE"
        Locate 3, 15: Print "C_eff(x,t) = a·I·R·T·e^ß(K-Kc)·z(-1)"
        Locate 5, 20: Print "t =";
        Print Using "####.##"; physT
        Locate 6, 20: Print "Emerg range:";
        Print Using "####.##"; minEmerg#;
        Print " to";
        Print Using "####.##"; maxEmerg#
        Color 7
    End If

    ' COPY BUFFER TO SCREEN - ORIGINELE WERKENDE METHODE
    For y = 1 To 480
        For x = 1 To 640
            PSet (x - 320, y - 240), buffer(x, y)
        Next x
    Next y

    ' MODE INFO
    Locate 1, 2
    Print "3D DEMO: [1] CUBE [2] DONUT [3] ASCII DONUT [4] SUB-PLANCK KOSMOS"
    Locate 2, 2
    If mode = 1 Then
        Print "Current: ROTATING CUBE"
    ElseIf mode = 2 Then
        Print "Current: 3D DONUT (Z-buffer)"
    ElseIf mode = 3 Then
        Print "Current: MANDELBROT-INFUSED ASCII DONUT (Z-buffer)"
    ElseIf mode = 4 Then
        Print "Current: SUB-PLANCK QUANTUM EMERGENTIE"
    End If
    Locate 2, 60: Print "Press ESC to exit"

    ' SIMPLE DELAY
    For delay = 1 To 200: Next delay
Loop Until k$ = Chr$(27)

Screen 0: Width 80
Print "Dank je voor het kijken naar de geboorte van het heelal in QBasic."
End

DrawLineToBuffer:
x1 = projX1: y1 = projY1: x2 = projX2: y2 = projY2
dx = Abs(x2 - x1): dy = Abs(y2 - y1)
If x1 < x2 Then sx = 1 Else sx = -1
If y1 < y2 Then sy = 1 Else sy = -1
err1 = dx - dy
Do
    If x1 >= 1 And x1 <= 640 And y1 >= 1 And y1 <= 480 Then buffer(x1, y1) = colr
    If x1 = x2 And y1 = y2 Then Exit Do
    e2 = 2 * err1
    If e2 > -dy Then
        err1 = err1 - dy
        x1 = x1 + sx
    End If
    If e2 < dx Then
        err1 = err1 + dx
        y1 = y1 + sy
    End If
Loop
Return

