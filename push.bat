@echo off
echo ����ͬ��github�ֿ�
git pull origin main

echo ������������ļ����ݴ���
git add .

:: ��ʽ�����ں�ʱ��
for /f "tokens=1-3 delims=/- " %%a in ("%date%") do (
    set year=%%a
    set month=%%b
    set day=%%c
)
for /f "tokens=1-3 delims=:.," %%a in ("%time%") do (
    set hour=%%a
    set minute=%%b
)

:: ȥ��Сʱǰ��Ŀո����Сʱ�ǵ�����
set hour=%hour: =%

:: ��ϳ� "�� �� �� ʱ ��" ��ʽ
set formatted_time=%year%��%month%��%day%��%hour%ʱ%minute%��

:: ѯ���Ƿ��Զ����ύ��Ϣ
:input_confirm
set /p confirm=�Ƿ��Զ����ύ��Ϣ��(���� y �� n): 
if "%confirm%"=="" (
    echo ���벻��Ϊ�գ����������룡
    goto input_confirm
)

if "%confirm%"=="y" (
    :input_msg
    set /p commit_msg=�������ύ��Ϣ: 
    if "%commit_msg%"=="" (
        echo ���벻��Ϊ�գ����������룡
        goto input_msg
    )
    git commit -m "%commit_msg%"
) else (
    git commit -m "%formatted_time%"
)

echo �������͵�Զ�ֿ̲�
git push -u origin main

echo ������ɣ�
pause